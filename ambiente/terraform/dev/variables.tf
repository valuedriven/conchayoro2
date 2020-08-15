
variable "HostServer" {
  default = "localhost"
}

variable "PortServer" {
  default = "80"
}

variable "PortServerContainer" {
  default = "8080"
}

variable "HostClient" {
  default = "localhost"
}

variable "PortClient" {
  default = "80"
}

variable "PortClientContainer" {
  default = "8080"
}

variable "HostDB" {
  default = "localhost"
}

variable "PortDB" {
  default = "80"
}

variable "PortDBContainer" {
  default = "8080"
}


variable "arquivoAmbiente" {
  default = ".env-dev"
}

variable "imagemServer" {
  default = ""
}

variable "imagemClient" {
  default = ""
}

variable "imagemDB" {
  default = ""
}
