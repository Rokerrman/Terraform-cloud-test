variable "virginia_cidr" {
     description = "CIDR_VIRGINIA"
     type = string
     # //para el workspace      type = map(string)
}

// variable "public_subnet" {
// description = "CIDR public subnet"
//  type = string
// }

// variable "private_subnet" {
//  description = "private subnet"
//  type = string
//}

variable "subnets"{
  description = "Lista de subnets"
  type = list(string)
}

variable "tags" {
  description = "tags del proyecto"
  type = map(string)
}

variable "sg_ingress_cidr" {
  description = "cidr for ingress traffic"
  type = string
}

variable "ec2_specs" {
  description = "Parametros de la instancia"
  type = map(string)
  
}

variable "ingress_ports_list" {
description = "Lista de puertos de ingress"
type = list(number)  
}

variable "acces_key" {}
variable "secret_key" {}