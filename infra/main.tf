provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "minecraft_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "minecraft_vpc"
  }
}

resource "aws_subnet" "minecraft_subnet" {
  vpc_id = aws_vpc.minecraft_vpc.id
  cidr_block = "10.0.0.0/24"

  tags = {
    Name = "minecraft_subnet"
  }
}

resource "aws_security_group" "minecraft_sg" {
  name = "Minecraft_security_group"
  vpc_id = aws_vpc.minecraft_vpc.id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  ingress {
    from_port = 25565
    to_port = 25565
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
    Name = "minecraft_security_group"
  }
}

resource "aws_key_pair" "minecraft_key" {
  key_name   = "minecraft_key"
  public_key = file("~/.ssh/aws_instance.pub")
}

resource "aws_instance" "minecraft_instance" {
    ami = "ami-0a0e5d9c7acc336f1"
    instance_type = "t2.micro"

    user_data = file("../user-data.sh")

    subnet_id = aws_subnet.minecraft_subnet.id
    vpc_security_group_ids = [ aws_security_group.minecraft_sg.id ]
    associate_public_ip_address = true

    key_name = aws_key_pair.minecraft_key.key_name
    tags = {
      Name= "minecraft_instance"
    }
}

