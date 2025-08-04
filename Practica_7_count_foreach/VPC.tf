resource "aws_vpc" "VPC_virginia" {
  cidr_block = var.virginia_cidr
 # /LINEA DE COMANDOS PARA DEFINIR POR WORKSPACE cidr_block = lookup(var.virginia_cidr,terraform.workspace)
  tags = {
    "Name" = "VPC_VIRGINIA-${local.sufix}" 
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.VPC_virginia.id
  cidr_block = var.subnets[0]
  map_public_ip_on_launch = true    //con esto es para asignar direcciones ip públicas a una instancia
  tags = {
    "Name" = "public_subnet" 
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id = aws_vpc.VPC_virginia.id
  cidr_block = var.subnets[1]
  tags = {
    "Name" = "private_subnet-${local.sufix}" 
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.VPC_virginia.id

  tags = {
    Name = "iwg VPN Virginia-${local.sufix}"
  }
}

resource "aws_route_table" "public_crt" {
  vpc_id = aws_vpc.VPC_virginia.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public crt-${local.sufix}"
  }
}

resource "aws_route_table_association" "crta_public_subnet" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_crt.id
}



resource "aws_security_group" "sg_public_instance" {
  name        = "public_instance_sg"
  description = "Allow SSH inbound traffic and all egress traffic"
  vpc_id      = aws_vpc.VPC_virginia.id

dynamic "ingress" {
  for_each = var.ingress_ports_list
  content {
    from_port = ingress.value
    to_port = ingress.value
    protocol = "tcp"
    cidr_blocks = [var.sg_ingress_cidr]
  } 
}

 
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
    ipv6_cidr_blocks = [ "::/0" ]
  }

  tags = {
    Name = "public instance sg-${local.sufix}"
  }
}

