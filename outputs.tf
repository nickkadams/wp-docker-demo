output "instance_id" {
  description = "List of Docker EC2 instance names"
  value       = aws_instance.docker[*].id
}

output "public_ip" {
  description = "List of Docker EC2 instance public IPs"
  value       = aws_instance.docker[*].public_ip
}

output "private_ip" {
  description = "List of Docker EC2 instance private IPs"
  value       = aws_instance.docker[*].private_ip
}

output "security_group_id" {
  description = "The ID of the security group"
  value       = module.security_group.this_security_group_id
}

output "security_group_name" {
  description = "The name of the security group"
  value       = module.security_group.this_security_group_name
}