# ec2/variables.tf

variable "ami" {
  description = "The ID of the AMI to use for the instances"
  type        = string
}

variable "instance_type" {
  description = "The instance type to use for the instances"
  type        = string
}

variable "public_subnet_id" {
  description = "The ID of the public subnet"
  type        = string
}

variable "private_subnet_id" {
  description = "The ID of the private subnet"
}

variable "security_group_id" {
  description = "The ID of the security group"
}

variable "key_name" {
  description = "The name of the key pair"
}

variable "private_key_pem" {
  description = "The private key in PEM format"
}

variable "user_data_file" {
  description = "The path to the user data file"
}