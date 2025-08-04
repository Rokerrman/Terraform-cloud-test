virginia_cidr = "10.10.0.0/16"

//Para la definicion de trabajar por workspaces
#virginia_cidr = {
# "prod" = "10.10.0.0/16"
# "dev"  =  "172.16.0.0/16"
#}

//public_subnet = "10.10.0.0/24"
//private_subnet = "10.10.1.0/24"

subnets = [ "10.10.0.0/24", "10.10.1.0/24" ]

tags = {
  "env" = "dev"
  "owner" = "Mike"
  "cloud" = "AWS"
  "iac" = "TERRAFORM"
  "project" = "cerberus"
  "region" = "virginia"
}

sg_ingress_cidr = "0.0.0.0/0"

ec2_specs = {
  "ami" = "ami-0150ccaf51ab55a51"
  "instance_type" = "t2.micro"
}

ingress_ports_list = [ 22,80,443 ]