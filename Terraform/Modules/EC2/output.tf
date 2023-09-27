output "type_public_id" {
  value = data.aws_instances.type_public.ids
}
output "type_private_id" {
  value = data.aws_instances.type_private.ids
}