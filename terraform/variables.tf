# Define variables for EC2.tf 
variable "key_name" {
  description = "The name of the key pair"
  default     = "minecraft_key"
}

variable "public_key_path" {
  description = "The path to the public key file"
  default     = "~/.ssh/aws_instance.pub"
}

variable "ami" {
  description = "The ID of the AMI to use for the instance"
  default     = "ami-0a0e5d9c7acc336f1"
}

variable "instance_type" {
  description = "The type of the EC2 instance"
  default     = "t3.medium"
}

variable "user_data_file" {
  description = "The path to the user data script"
  default     = "user-data.sh"
}

variable "availability_zone" {
  description = "The availability zone where the instance will be launched"
  default     = "us-east-1a"
}

variable "tags" {
  description = "Tags to apply to the instance"
  type        = map(string)
  default = {
    Name = "minecraft_instance"
  }
}

# ------------------------------

