resource "aws_route_table" "minecraft_rt" {
  vpc_id = aws_vpc.minecraft_vpc.id

  route {
    cidr_block = var.cidr_block
    gateway_id = aws_internet_gateway.minecraft_igw.id
  }

  tags = {
    Name = "${var.prefix}_rt"
  }
}

resource "aws_route_table_association" "minecraft_rta" {
  subnet_id      = aws_subnet.minecraft_subnet.id
  route_table_id = aws_route_table.minecraft_rt.id
}
