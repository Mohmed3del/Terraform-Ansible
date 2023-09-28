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
# output "security_group_ids" {
#   description = "Security Group IDs created by aws_security_group"
#   value = {
#     for sg_name, sg in aws_security_group.allow_sg :
#     sg_name => sg.id
#   }
# }
output "security_group_ids" {
  value = { for sg in aws_security_group.allow_sg : sg.tags["Name"] => sg.id }

}
