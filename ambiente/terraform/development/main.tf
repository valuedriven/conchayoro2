resource "null_resource" "DeployDev" {
  
  provisioner "local-exec" {
    command = "sh ambiente/terraform/development/excluirContainerLocal.sh"
  }
  provisioner "local-exec" {
    //command = "docker run --rm -d --hostname ${var.DBHost} --name containerDB --env-file ${var.envFileDB} -p ${var.DBPort}:${var.DBContainerPort} ${var.imageDB}"
    command = "docker run --rm -d --env-file ${var.envFileDB} --hostname ${var.DBHost} --name containerDB -p ${var.DBPort}:${var.DBContainerPort} ${var.imageDB}"
  }
  provisioner "local-exec" {
    command = "docker run --rm -d --env-file ${var.envFileServer} --hostname ${var.ServerHost} --name containerServer -p ${var.ServerPort}:${var.ServerContainerPort} ${var.imageServer}"
  }
  provisioner "local-exec" {
    command = "docker run --rm -d --env-file ${var.envFileClient} --hostname ${var.ClientHost} --name containerClient  -p ${var.ClientPort}:${var.ClientContainerPort} ${var.imageClient}"
  }
}