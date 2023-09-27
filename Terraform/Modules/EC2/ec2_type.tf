
data "aws_instances" "type_public"{
  depends_on = [aws_instance.EC2_instance]
  filter {
    name = "tag:type"
    values = ["public"]
  }
}
data "aws_instances" "type_private"{
  depends_on = [aws_instance.EC2_instance]
  filter {
    name = "tag:type"
    values = ["private"]
  }
}
