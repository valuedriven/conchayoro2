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


DATABASE_SERVER_HOST=localhost
DATABASE_SERVER_PORT=5432
DATABASE_SERVER_CONTAINER_PORT=5432
POSTGRES_USER=postgresuser
POSTGRES_PASSWORD=postgrespwd
POSTGRES_DB=conchayorodb
DATABASE_SERVER_USER=conchayorouser
DATABASE_SERVER_PASSWORD=conchayoropwd
