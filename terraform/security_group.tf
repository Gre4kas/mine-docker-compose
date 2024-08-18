resource "aws_security_group" "minecraft_sg" {
  name   = "${var.prefix}_security_group"
  vpc_id = aws_vpc.minecraft_vpc.id

# ssh port
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.cidr_block]
  }

# minecaft port
  ingress {
    from_port   = 25565
    to_port     = 25565
    protocol    = "tcp"
    cidr_blocks = [var.cidr_block]
  }
# monitoring port
  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = [var.cidr_block]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.cidr_block]
  }

  tags = {
    Name = "${var.prefix}_security_group"
  }
}