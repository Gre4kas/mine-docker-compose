resource "aws_subnet" "minecraft_subnet" {
  vpc_id = aws_vpc.minecraft_vpc.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "minecraft_subnet"
  }
}
