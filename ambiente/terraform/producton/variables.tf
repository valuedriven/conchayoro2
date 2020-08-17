variable "instance_image" {
  default = "ami-0fc61db8544a617ed"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "user" {
  default = "ec2-user"
  #default = "conchayoro_user"
}

variable "public_key_file" {
  default = "~/.ssh/conchayoro.pub"
}

variable "private_key_file" {
  default = "~/.ssh/conchayoro"
}

variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}

variable "subnet_cidr_block" {
  default = "10.0.1.0/24"
}

variable "destinationCIDRblock" {
  default = "0.0.0.0/0"
}

variable "ingress_cidr_block" {
  type    = list
  default = ["0.0.0.0/0"]
}

variable "egress_cidr_block" {
  type    = list
  default = ["0.0.0.0/0"]
}

variable "APP_SERVER_CONTAINER_PORT" {
  default = "8080"
}

variable "arquivoAmbiente" {
  default = ""
}

variable "imagem" {
  default = ""
}

variable "Host" {
  default = "localhost"
}

variable "Port" {
  default = "80"
}