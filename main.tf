provider "aws" {
  region  = "us-east-1"
 # profile = "default"
}

module "network" {
  source = "./modules/network"

  cidr_block = "10.0.0.0/16"
  public_subnet_cidr = "10.0.1.0/24"
  private_subnet_cidr = "10.0.2.0/24"
}

module "ssh" {
  source = "./modules/ssh"
  key_name = var.key_name   
}

module "ec2_instance" {
  source = "./modules/ec2"

  ami                    = "ami-06c40dd4f80434809"
  instance_type          = "t2.micro"
  public_subnet_id       = module.network.public_subnet_id
  private_subnet_id      = module.network.private_subnet_id
  security_group_id      = module.network.security_group_id
  key_name               = module.ssh.key_name
  private_key_pem        = module.ssh.private_key_pem
  user_data_file         = "user.sh"
}
