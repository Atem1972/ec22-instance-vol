# Create an EC2 instance and an EBS volume

resource "aws_instance" "server1" {
  ami             = "ami-026b57f3c383c2eec"
  instance_type   = "t2.micro"
  tags = {
    Name = "Terraform server"
    Team = "DevOps"
    env  = "dev"
  }
  user_data = file("install.sh")
}

resource "aws_ebs_volume" "vol1" {
  availability_zone = aws_instance.server1.availability_zone
  size              = 10
  tags = {
    Name       = "terraform volume"
    Team       = "Cloud"
    created-by = "Terraform"
  }
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.vol1.id
  instance_id = aws_instance.server1.id
}

# Create a default VPC if one does not exist
resource "aws_default_vpc" "default_vpc" {}

# Create EC2 Docker instance
data "aws_ami" "amazon-2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }
  owners = ["amazon"]
}

resource "aws_instance" "DockerInstance" {
  ami                    = data.aws_ami.amazon-2.id
  instance_type          = "t2.medium"
  vpc_security_group_ids = [aws_security_group.web-sg.id]
  key_name               = aws_key_pair.ec2_key.key_name
  user_data              = file("install.sh")
  root_block_device {
    volume_size = 30
    volume_type = "gp2"
  }
  tags = {
    Name = "docker-instance"
  }
}
