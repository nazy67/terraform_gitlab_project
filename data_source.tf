### Cloud init to install GitLab
data "template_file" "user_data" {
  template = file("template_file/install_glab.yaml")
  vars = {
    env = "shared_servs"
  }
}

### Route 53 zone data source

data "aws_route53_zone" "my_zone" {
  name = var.hz_name
}

### Data source for AMI
data "aws_ami" "amazon_linux2" {
  most_recent = true
  owners      = ["amazon"] # ami owner

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0*"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}