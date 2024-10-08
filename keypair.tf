# Generate a private key and create a key pair

resource "tls_private_key" "ec2_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "ec2_key" {
  key_name   = "week7d2"
  public_key = tls_private_key.ec2_key.public_key_openssh
}

resource "local_file" "ssh_key" {
  filename = "week7d2.pem"
  content  = tls_private_key.ec2_key.private_key_pem
  file_permission = "400"
}