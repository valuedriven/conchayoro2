
variable "HostServer" {
  default = "localhost"
}

variable "PortServer" {
  default = "80"
}

variable "HostClient" {
  default = "localhost"
}

variable "PortClient" {
  default = "80"
}

variable "ServerContainerPort" {
  default = "8080"
}

variable "ClientContainerPort" {
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
