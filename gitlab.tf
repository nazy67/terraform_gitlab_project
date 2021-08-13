### Gitlab server
resource "aws_instance" "gitlab_server" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.gitlab_sg.id]
  user_data              = data.template_file.user_data.rendered
  subnet_id              = var.subnet_id
  key_name               = var.my_key
  tags                   = var.glab_tags
}