variable "key_name" {
  description = "The name of the key pair"
  default = "ec2-keypair"
}

variable "private_key_pem" {
  description = "The private key in PEM format"
  default     = "-----BEGIN RSA PRIVATE KEY-----\n..."
}