resource "aws_subnet" "minecraft_subnet" {
  vpc_id            = aws_vpc.minecraft_vpc.id
  cidr_block        = var.cidr_block_subnet
  availability_zone = var.availability_zone

  tags = {
    Name = "${var.prefix}_subnet"
  }
}
