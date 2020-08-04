provider "aws" {

}

#TODO: implementação de remote backend
# terraform {
#   backend "s3" {
#     bucket = "conchayoro-remote-store"
#     key    = "conchayoro_pro.tfstate"
#     #region = "us-east-1"
#   }
# }

resource "aws_instance" "conchayoro_instance" {
  ami                    = var.instance_image
  instance_type          = var.instance_type
  key_name               = aws_key_pair.conchayoro_key_pair.key_name
  vpc_security_group_ids = [aws_security_group.conchayoro_sg.id]

  connection {
    type        = "ssh"
    user        = var.user
    private_key = file(var.private_key_file)
    host        = self.public_ip
  }
  
  provisioner "local-exec" {
    command = "ansible-playbook -vvv -u '${AWS_USER}' -i '${self.public_ip},' --private-key ${var.private_key_file} ambiente/ansible/dev/dev.yml --ssh-common-args='-o StrictHostKeyChecking=no'"
  }

  provisioner "remote-exec" {
    inline = [
       "docker run -d --env-file ${var.arquivoAmbiente} -p ${var.APP_SERVER_PORT}:${var.APP_SERVER_CONTAINER_PORT} ${var.imagem}"
    ]
  }

}


