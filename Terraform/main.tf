module "network" {
  source   = "./Modules/network"
  Name     = var.Name
  vpc_cidr = var.vpcid

  vpc_subnets = {
    "public1" = {
      cidr        = var.public1["cidr"]
      AZ          = 0
      route_table = "public_route"
      map_pub     = true
    }
    "private1" = {
      cidr        = var.private1["cidr"]
      AZ          = 0
      route_table = "private_route"
      map_pub     = false
    }
    "public2" = {
      cidr        = var.public2["cidr"]
      AZ          = 1
      route_table = "public_route"
      map_pub     = true
    }
    "private2" = {
      cidr        = var.private2["cidr"]
      AZ          = 1
      route_table = "private_route"
      map_pub     = false
    }
  }

  route_table = {
    "public_route" = {
      cidr       = "0.0.0.0/0"
      gateway_id = module.network.gateway_id
    }
    "private_route" = {
      cidr       = "0.0.0.0/0"
      gateway_id = module.network.nat
    }
  }
}

module "EC2" {
  source = "./Modules/EC2"
  Name   = var.Name

  vpc_id = module.network.vpcid

  #EC2


  instance_ami = {
    name_ami = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
    owners   = ["amazon"]
  }
  instance_type = var.instance_type
  EBS_volume    = 8
  key_pair      = var.key_pair
  ec2 = {
    "public1" = {
      ec2_subnet_id                = module.network.subnet_id["public1"]
      associate_map_public_address = true
      security_group               = "public_security_group"

    }
    "public2" = {
      ec2_subnet_id                = module.network.subnet_id["public2"]
      associate_map_public_address = true
      security_group               = "public_security_group"

    }
    "private1" = {
      ec2_subnet_id                = module.network.subnet_id["private1"]
      associate_map_public_address = false
      security_group               = "private_security_group"

    }
    "private2" = {
      ec2_subnet_id                = module.network.subnet_id["private2"]
      associate_map_public_address = false
      security_group               = "private_security_group"

    }
  }



  #Security Group
  ec2_sg = {
    public_security_group = {
      ingress_rules = [{ port = "22", protocol = "tcp", cidr_blocks = ["${chomp(data.http.myip.body)}/32"] },
        { port = "80", protocol = "tcp", cidr_blocks = [var.IPS] },
      { port = "433", protocol = "tcp", cidr_blocks = [var.IPS] }]
      egress_rules = [{ port = "0", protocol = "-1", cidr_blocks = [var.IPS] }]

    }
    private_security_group = {
      ingress_rules = [{ port = "22", protocol = "tcp", cidr_blocks = [var.IPS] },
        { port = "80", protocol = "tcp", cidr_blocks = [var.IPS] },
      { port = "433", protocol = "tcp", cidr_blocks = [var.IPS] }]
      egress_rules = [{ port = "0", protocol = "-1", cidr_blocks = [var.IPS] }]

    }
  }
}

module "Load_Balancer" {
  source          = "./Modules/LoadBalancer"
  vpc_id          = module.network.vpcid
  subnets_id      = [module.network.subnet_id["public1"], module.network.subnet_id["public2"]]
  security_groups =  [module.EC2.security_group_ids["private_security_group"]]


  load_balancers = {
    "public" = {
      internal = false
      type     = "network"
      port     = 80
      protocol = "TCP"
      target_groups = [
        {
          target_group_name = "example-tg-1"
          port              = 80
          protocol          = "TCP"
        }
      ]
    },
    "private" = {
      internal = true
      type     = "application"
      port     = 80
      protocol = "HTTP"
      target_groups = [
        {
          target_group_name = "example-tg-2"
          port              = 80
          protocol          = "HTTP"
        }
      ]
    }
  }

  type_id = {
    "public"  = module.EC2.type_public_id
    "private" = module.EC2.type_private_id
  }

}

