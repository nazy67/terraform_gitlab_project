data "aws_ami" "amazon_linux2" {
  most_recent = true
  owners      = ["amazon"] # it can be "self" if you use your own ami or "account_number" of the ami owner

  filter { # dictionary or map
    name   = "name"
    values = ["amzn2-ami-hvm-2.0*"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}