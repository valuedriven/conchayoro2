resource "null_resource" "DeployDev" {
  
  provisioner "local-exec" {
    command = "sh ambiente/terraform/development/excluirContainerLocal.sh"
  }
  provisioner "local-exec" {
    //command = "docker run --rm -d --hostname ${var.DBHost} --name containerDB --env-file ${var.envFileDB} -p ${var.DBPort}:${var.DBContainerPort} ${var.imageDB}"
    command = "docker run --rm -d --network n1 --env-file ${var.envFileDB} --name ${var.DBHost} -p ${var.DBPort}:${var.DBContainerPort} ${var.imageDB}"
  }
  provisioner "local-exec" {
    command = "docker run --rm -d --network n1 --env-file ${var.envFileServer}  --name ${var.ServerHost} -p ${var.ServerPort}:${var.ServerContainerPort} ${var.imageServer}"
  }
  provisioner "local-exec" {
    command = "docker run --rm -d --network n1 --env-file ${var.envFileClient} --name ${var.ClientHost} -p ${var.ClientPort}:${var.ClientContainerPort} ${var.imageClient}"
  }
}