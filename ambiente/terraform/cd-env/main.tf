resource "null_resource" "cd-env" {

  connection {
    type = "ssh"
    user = "ip172-18-0-3-bqmse6aosm4g009esnm0"
    host = "direct.labs.play-with-docker.com"
    private_key = file("~/.ssh/conchayoro")
  }
  provisioner "remote-exec" {
    inline = [
      "ls -la"
    ]
  }
}