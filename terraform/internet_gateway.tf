resource "aws_internet_gateway" "minecraft_igw" {
  vpc_id = aws_vpc.minecraft_vpc.id

  tags = {
    Name = "${var.prefix}_igw"
  }
}