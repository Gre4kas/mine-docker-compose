output "aws_public_ip" {
  value = aws_instance.minecraft_instance.public_ip
}