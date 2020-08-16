resource "null_resource" "DeployDev" {
  
  provisioner "local-exec" {
    command = "sh ambiente/terraform/dev/excluirContainerLocal.sh"
  }
  provisioner "local-exec" {
    //command = "docker run --rm -d --name containerLocalDB --env-file ${var.arquivoAmbiente} -p ${var.PortDB}:${var.PortDBContainer} ${var.imagemDB}"
    command = "docker run --rm -d --name containerLocalDB --env-file ${var.arquivoAmbiente} -p ${var.DATABASE_SERVER_PORT}:${var.DATABASE_SERVER_CONTAINER_PORT} ${var.imagemDB}"
  }
  provisioner "local-exec" {
    command = "docker run --rm -d --name containerLocalServer --env-file ${var.arquivoAmbiente} -p ${var.PortServer}:${var.PortServerContainer} ${var.imagemServer}"
  }
  provisioner "local-exec" {
    command = "docker run --rm -d --name containerLocalClient --env-file ${var.arquivoAmbiente} -p ${var.PortClient}:${var.PortClientContainer} ${var.imagemClient}"
  }
}