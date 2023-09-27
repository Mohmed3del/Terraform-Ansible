# aws region
region = "us-east-1"

# cidr block vpc

Name = "DevOps"


key_pair = "DevOps"
vpcid    = "10.0.0.0/16"

IPS = "0.0.0.0/0"

public1 = {
  cidr = "10.0.1.0/24"
}

public2 = {
  cidr = "10.0.2.0/24"
}

private1 = {
  cidr = "10.0.3.0/24"
}

private2 = {
  cidr = "10.0.4.0/24"
}
# EKS

instance_type = "t2.micro"



