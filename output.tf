# Output values

output "public_ip" {
  value = aws_instance.server1.public_ip
}

output "az" {
  value = aws_instance.server1.availability_zone
}

output "ssh-command" {
  value = "ssh -i week7d2.pem ec2-user@${aws_instance.server1.public_ip}"
}

output "docker-instance-ssh-command" {
  value = "ssh -i ${aws_key_pair.ec2_key.key_name}.pem ec2-user@${aws_instance.DockerInstance.public_dns}"
}

output "docker-instance-public-ip" {
  value = aws_instance.DockerInstance.public_ip
}
