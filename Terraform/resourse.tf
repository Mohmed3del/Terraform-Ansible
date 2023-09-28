resource "null_resource" "out" {
  triggers = {
    always_run = "${timestamp()}"
  }
  provisioner "local-exec" {
    command =<<EOF
      ../Script/inventory.sh ${module.EC2.ec2["public1"].public_ip} ${module.EC2.ec2["public2"].public_ip} ${module.EC2.ec2["private1"].private_ip} ${module.EC2.ec2["private2"].private_ip} ${module.Load_Balancer.load_balancers["private"].dns_name}
      ../Script/ssh_config.sh ${module.EC2.ec2["public1"].public_ip} ${module.EC2.ec2["private1"].private_ip} ${module.EC2.ec2["private2"].private_ip}
    EOF
  }

  depends_on = [
    module.EC2,
    module.Load_Balancer
  ]
}

