resource "aws_instance" "project_ec2" {
  depends_on             = [ aws_security_group.project_sg ]
  ami                    = "ami-0be2609ba883822ec"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [ aws_security_group.project_sg.id ]
  user_data = data.local_file.user_data.content
  tags = {
    Name        = "ec2_project"
    Environment = var.env 
  }
}
resource "aws_security_group" "project_sg" {
  name        = "allow_22_80"
  description = "Allow TLS inbound traffic"

  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "project_sg"
  }
}
