#VPC
variable "vpc_id" {
  type = string
}

variable "Name" {
  type = string
}

#Instance


variable "ec2" {
  type = map(object({
    associate_map_public_address = bool
    ec2_subnet_id                = string
    security_group               = string
  }))
}

variable "instance_ami" {
  type = object({
    owners   = list(string)
    name_ami = list(string)
  })
}

variable "instance_type" {
  type = string
}

variable "key_pair" {
  type = string
}





variable "EBS_volume" {
  type = string
}

#Security Group

# variable "sg_rules" {
#   type = map(object({
#     type        = string
#     port        = number
#     protocol    = string
#     cidr_blocks = list(string)
#   }))
# }
variable "ec2_sg" {
  description = "Security groups for EC2 instances"
  type = map(object({
    ingress_rules = list(object({
      port        = number
      protocol    = string
      cidr_blocks = list(string)
    }))
    egress_rules = list(object({
      port        = number
      protocol    = string
      cidr_blocks = list(string)
    }))
  }))
}
