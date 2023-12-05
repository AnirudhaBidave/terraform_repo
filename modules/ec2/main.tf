#ec2

# provider "aws" {
#   region  = "us-east-1"
#   profile = "default"
# }

resource "aws_instance" "public_instance" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = var.public_subnet_id
  vpc_security_group_ids = [var.security_group_id]
  key_name               = var.key_name

  tags = {
    Name = "Public Instance"
  }

  # user_data = file("user.sh")

  provisioner "remote-exec" {
    inline = [
      "sudo amazon-linux-extras install -y nginx1",
      "sudo service nginx start",
      "sudo echo '${var.private_key_pem}' > /home/ec2-user/private_key.pem",
      "sudo chmod 400 /home/ec2-user/private_key.pem"

    ]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = var.private_key_pem
      host = self.public_ip
    }
  }
}

resource "aws_instance" "private_instance" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = var.private_subnet_id
  vpc_security_group_ids = [var.security_group_id]
  key_name               = var.key_name
  tags = {
    Name = "Private Instance"
  }

    user_data = file(var.user_data_file)
  # provisioner "remote-exec" {
  #   inline = [
  #     "sleep 60",
  #     "sudo yum install -y nginx",
  #     "sudo service nginx start"
  #   ]

  #   connection {
  #     type        = "ssh"
  #     user        = "ec2-user"
  #     private_key = tls_private_key.ssh_key.private_key_pem
  #     host = aws_instance.public_instance.public_ip
  #   }
  # }
}