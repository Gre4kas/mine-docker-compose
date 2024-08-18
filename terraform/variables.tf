# Define variables for providers.tf
variable "aws_region" {
  default     = "us-east-1"
  description = "aws region"
}

# Define variables for EC2.tf 
variable "key_name" {
  description = "The name of the key pair"
  default     = "minecraft_key"
}

variable "prefix" {
  description = "Prefix for tag"
  type        = string
  default     = "minecraft"
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

# Networks 

variable "cidr_block" {
  description = "CIDR block for the network, default is 0.0.0.0/0 (allows all inbound traffic)"
  type        = string
  default     = "0.0.0.0/0"
}

variable "cidr_block_subnet" {
  description = "CIDR block for the subnet, default is 10.0.0.0/24"
  type        = string
  default     = "10.0.0.0/24"
}
