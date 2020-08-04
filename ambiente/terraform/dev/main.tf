resource "null_resource" "DeployDev" {
  
  provisioner "local-exec" {
    command = "sh ambiente/terraform/dev/excluirContainerLocal.sh"
  }
  provisioner "local-exec" {
    command = "docker run --rm -d --name containerLocal --env-file ${var.arquivoAmbiente} -p ${var.Port}:${var.ContainerPort} ${var.imagem}"
  }
}