### AWS Provider variable
variable "aws_region" {
  description = "aws region to deploy resources"
  type        = string
  default     = "us-east-1"
}

### GitLab server variables
variable "instance_type" {
  description = "type on the EC2 instance"
  type        = string
  default     = "t2.medium"
}
variable "ami_id" {
  description = "Centos 7 AMI"
  type        = string
  default     = "ami-0affd4508a5d2481b"
}
variable "subnet_id" {
  description = "default public subnet id"
  type        = string
  default     = "subnet-3d32a333"
}
variable "my_key" {
  description = "local laptop's key"
  type        = string
  default     = "new-key"
}

### GitLab Security Group Variables
variable "ingress" {
  type        = map(map(any))
  description = "allow traffic on port 22 from listed IPs"
  default = {
    1 = { from = 22, to = 22, protocol = "tcp", cidr = "0.0.0.0/0", desc = "allow ssh traffic to all" },
    2 = { from = 80, to = 80, protocol = "tcp", cidr = "0.0.0.0/0", desc = "allow http traffic to all" },
    3 = { from = 443, to = 443, protocol = "tcp", cidr = "0.0.0.0/0", desc = "allow https traffic to all" },
  }
}

variable "default_vpc_id" {
  description = "default vpc id"
  type        = string
  default     = "vpc-de28c3a3"
}

### Route 53 variables
variable "hz_name" {
  description = "Name of route 53 zone"
  type        = string
  default     = "nazydaisy.com."
}

### Tag variables
variable "glab_tags" {
  type = map(any)
  default = {
    Name        = "gitlab_instance"
    Environment = "shared_servs"
    ProjectName = "gitlab"
    Giturl      = "https://github.com/nazy67/terraform_gitlab_project"
    Owner       = "nazykh67@gmail.com"
  }
}

variable "glab_sg_tags" {
  type = map(any)
  default = {
    Name        = "gitlab_sg"
    Environment = "shared_servs"
    ProjectName = "gitlab"
    Giturl      = "https://github.com/nazy67/terraform_gitlab_project"
    Owner       = "nazykh67@gmail.com"
  }
}