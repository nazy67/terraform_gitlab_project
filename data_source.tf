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