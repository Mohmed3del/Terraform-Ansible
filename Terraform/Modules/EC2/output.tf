output "type_public_id" {
  value = data.aws_instances.type_public.ids
}
output "type_private_id" {
  value = data.aws_instances.type_private.ids
}

output "ec2" {
  description = "List of EC2 instances created"
  value       = aws_instance.EC2_instance
}