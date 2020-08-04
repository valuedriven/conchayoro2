resource "null_resource" "DeployTes" {

  provisioner "local-exec" {    
    command = "docker login --username=${HEROKU_EMAIL} --password=${HEROKU_API_KEY} registry.heroku.com"
  }

  provisioner "local-exec" {    
    command = "docker tag ${var.imagem} registry.heroku.com/${PROJECT_NAME}/web"
  }

  provisioner "local-exec" {    
    command = "docker push registry.heroku.com/${PROJECT_NAME}/web"
  }

  provisioner "local-exec" {    
    command = "heroku config:push -f ${var.arquivoAmbiente} --app ${PROJECT_NAME}"    
  }
  
  provisioner "local-exec" {    
    command = "heroku container:release web --app ${PROJECT_NAME}"
  }

}