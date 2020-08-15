
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

variable "ContainerPort" {
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
