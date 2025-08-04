 variable "instancias" {
   description = "nombre de las instancias"
   type = set(string) 
  # type = list(string)  //para el count
   default = [ "apache" ]
 }
 
 
 
 resource "aws_instance" "public_instance" {
 #count = length(var.instancias)    //Tener cuidado al eliminar, ya que la instancias cuenta con una lista, si se quita un valor del array, va a borrar el recurso del index que ya no vea
  for_each                = toset(var.instancias)
  ami                     = var.ec2_specs.ami
  instance_type           = var.ec2_specs.instance_type
  subnet_id               = aws_subnet.public_subnet.id
  key_name                = data.aws_key_pair.key.key_name
  vpc_security_group_ids  = [ aws_security_group.sg_public_instance.id]
  user_data               = file("userdata.sh")

  tags = {
    #"Name" = var.instancias[count.index]   // es para el count
    "Name" = "${each.value}-${local.sufix}"    //es para el for_each
  }
 }

/* resource "aws_instance" "monitoring_instance" {
  count                   = var.enable_monitoring != 1 ? 1 : 0
  ami                     = var.ec2_specs.ami
  instance_type           = var.ec2_specs.instance_type
  subnet_id               = aws_subnet.public_subnet.id
  key_name                = data.aws_key_pair.key.key_name
  vpc_security_group_ids  = [ aws_security_group.sg_public_instance.id]
  user_data               = file("userdata.sh")

  tags = {
    #"Name" = var.instancias[count.index]   // es para el count
    "Name" = each.value    // es para el for_each
  } 
  }
  */ 
  

  