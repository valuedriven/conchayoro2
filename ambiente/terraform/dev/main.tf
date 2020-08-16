resource "null_resource" "DeployDev" {
  
  provisioner "local-exec" {
    command = "sh ambiente/terraform/dev/excluirContainerLocal.sh"
  }
  provisioner "local-exec" {
    command = "docker run --rm -d --name containerLocalDB --env-file ${var.arquivoAmbiente} -p ${var.DBPort}:${var.DBContainerPort} ${var.imagemDB}"
  }
  provisioner "local-exec" {
    command = "docker run --rm -d --name containerLocalServer --env-file ${var.arquivoAmbiente} -p ${var.ServerPort}:${var.ServerContainerPort} ${var.imagemServer}"
  }
  provisioner "local-exec" {
    command = "docker run --rm -d --name containerLocalClient --env-file ${var.arquivoAmbiente} -p ${var.ClientPort}:${var.ClientContainerPort} ${var.imagemClient}"
  }
}