resource "aws_instance" "EC2_instance" {
  for_each                    = var.ec2
  ami                         = data.aws_ami.instance_ami.id
  instance_type               = var.instance_type
  subnet_id                   = each.value["ec2_subnet_id"]
  key_name                    = var.key_pair
  vpc_security_group_ids      = [aws_security_group.allow_sg[each.value["security_group"]].id]
  associate_public_ip_address = each.value["associate_map_public_address"]
  root_block_device {
    volume_size = var.EBS_volume
  }

  tags = {
    Name = each.key
    type = each.value["associate_map_public_address"] == true ?  "public" : "private"
  }
}
