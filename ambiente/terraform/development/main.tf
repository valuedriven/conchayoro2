resource "null_resource" "DeployDev" {
  
  provisioner "local-exec" {
    command = "sh ambiente/terraform/development/excluirContainerLocal.sh"
  }
  provisioner "local-exec" {
    command = "docker run --rm -d --hostname ${var.DBHost} --name containerDB --env-file ${var.envFileServer} -p ${var.DBPort}:${var.DBContainerPort} ${var.imageDB}"
  }
  provisioner "local-exec" {
    command = "docker run --rm -d --hostname ${var.ServerHost} --name containerServer --env-file ${var.envFileServer} -p ${var.ServerPort}:${var.ServerContainerPort} ${var.imageServer}"
  }
  provisioner "local-exec" {
    command = "docker run --rm -d --hostname ${var.ClientHost} --name containerClient --env-file ${var.envFileClient} -p ${var.ClientPort}:${var.ClientContainerPort} ${var.imageClient}"
  }
}