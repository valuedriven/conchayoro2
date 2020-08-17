resource "aws_key_pair" "conchayoro_key_pair" {
  key_name   = uuid()
  public_key = file(var.public_key_file) 
}