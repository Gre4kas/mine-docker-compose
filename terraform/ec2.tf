# Resource definitions
resource "aws_key_pair" "minecraft_key" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)
}

resource "aws_instance" "minecraft_instance" {
  ami                         = var.ami
  instance_type               = var.instance_type
  user_data                   = file(var.user_data_file)
  availability_zone           = var.availability_zone

  subnet_id                   = aws_subnet.minecraft_subnet.id
  vpc_security_group_ids      = [ aws_security_group.minecraft_sg.id ]
  associate_public_ip_address = true

  key_name = aws_key_pair.minecraft_key.key_name

  tags = var.tags
}
