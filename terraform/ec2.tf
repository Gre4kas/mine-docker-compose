resource "aws_key_pair" "minecraft_key" {
  key_name   = "minecraft_key"
  public_key = file("~/.ssh/aws_instance.pub")
}

resource "aws_instance" "minecraft_instance" {
    ami = "ami-0a0e5d9c7acc336f1"
    instance_type = "t3.medium"
    user_data = file("user-data.sh")
    availability_zone = "us-east-1a"

    subnet_id = aws_subnet.minecraft_subnet.id
    vpc_security_group_ids = [ aws_security_group.minecraft_sg.id ]
    associate_public_ip_address = true

    key_name = aws_key_pair.minecraft_key.key_name
    tags = {
      Name= "minecraft_instance"
    }
}
