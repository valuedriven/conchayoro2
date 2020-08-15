resource "null_resource" "DeployDev" {
  
  provisioner "local-exec" {
    command = "sh ambiente/terraform/dev/excluirContainerLocal.sh"
  }
  provisioner "local-exec" {
    command = "docker run --rm -d --name containerLocalServer --env-file ${var.arquivoAmbiente} -p ${var.PortServer}:${var.ServerContainerPort} ${var.imagemServer}"
  }
  provisioner "local-exec" {
    command = "docker run --rm -d --name containerLocalClient --env-file ${var.arquivoAmbiente} -p ${var.PortClient}:${var.ClientContainerPort} ${var.imagemClient}"
  }
}