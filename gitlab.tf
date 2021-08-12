resource "aws_instance" "gitlab_server" {
  ami                    = data.aws_ami.amazon_linux2.image_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.gitlab_sg.id]
  user_data              = data.template_file.user_data.rendered
  key_name               = var.my_key
  tags                   = var.glab_tags
}