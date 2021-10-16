output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.gophish.public_ip
}

output "ssh" {
  value = "ssh -l ubuntu ${aws_instance.gophish.public_dns} -i $HOME/.ssh/id_rsa"
}
