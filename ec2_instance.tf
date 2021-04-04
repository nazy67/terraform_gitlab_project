data "template_file" "user_data" {
  template = file("user_data.sh")
}

resource "aws_instance" "project_ec2" {
  depends_on             = [ aws_security_group.project_sg ]
  ami                    = data.aws_ami.amazon_linux2.image_id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [ aws_security_group.project_sg.id ]
  user_data = data.template_file.user_data.rendered
  key_name = var.my_key
  tags = {
    Name        = "ec2_project"
    Environment = var.env 
  }
}

resource "aws_security_group" "project_sg" {
  name        = "allow_http"
  description = "Allow TLS inbound traffic"
  tags = {
    Name  = "allow_http"
  }
}
resource "aws_security_group_rule" "http_ingress" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.project_sg.id
}
resource "aws_security_group_rule" "ssh_ingress" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.project_sg.id
}
resource "aws_security_group_rule" "egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.project_sg.id
}