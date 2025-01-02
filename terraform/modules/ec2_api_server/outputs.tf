output "instance_id" {
  value = aws_instance.api_server.id
  description = "The ID of the EC2 instance"
}


output "security_group_id" {
  description = "The ID of the security group associated with the EC2 instance"
  value       = aws_security_group.api_sg.id
}
