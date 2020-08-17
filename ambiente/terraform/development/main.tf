resource "null_resource" "DeployDev" {
  
  provisioner "local-exec" {
    command = "sh ambiente/terraform/dev/excluirContainerLocal.sh"
  }
  provisioner "local-exec" {
    command = "docker run --rm -d --hostname ${var.DBHost} --name ${var.DBHost} --env-file ${var.arquivoAmbiente} -p ${var.DBPort}:${var.DBContainerPort} ${var.imagemDB}"
  }
  provisioner "local-exec" {
    command = "docker run --rm -d --hostname ${var.ServerHost} --name ${var.ServerHost} --env-file ${var.arquivoAmbiente} -p ${var.ServerPort}:${var.ServerContainerPort} ${var.imagemServer}"
  }
  provisioner "local-exec" {
    command = "docker run --rm -d --hostname ${var.ClientHost} --name ${var.ClientHost} --env-file ${var.arquivoAmbiente} -p ${var.ClientPort}:${var.ClientContainerPort} ${var.imagemClient}"
  }
}