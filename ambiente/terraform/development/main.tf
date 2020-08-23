resource "null_resource" "DeployDev" {
  
  provisioner "local-exec" {
    command = "sh ambiente/terraform/development/inicia-ambiente.sh ${var.ClientHost} ${var.ServerHost} ${var.DBHost}"
  }

  provisioner "local-exec" {
    command = "docker run --rm -d --env-file ${var.envFileDB} --hostname ${var.DBHost} --name ${var.DBHost} --network localNetwork -p ${var.DBPort}:${var.DBContainerPort} ${var.imageDB}"
  }
  provisioner "local-exec" {
    command = "docker run --rm -d --env-file ${var.envFileServer} --hostname ${var.ServerHost} --name ${var.ServerHost} --network localNetwork  -p ${var.ServerPort}:${var.ServerContainerPort} ${var.imageServer}"
  }
  provisioner "local-exec" {
    command = "docker run --rm -d --env-file ${var.envFileClient} --hostname ${var.ClientHost} --name ${var.ClientHost} --network localNetwork  -p ${var.ClientPort}:${var.ClientContainerPort} ${var.imageClient}"
  }
}