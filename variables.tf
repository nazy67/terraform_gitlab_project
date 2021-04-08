variable "tags" {
  type = map
  
  default = {
      "Name" = "ec2_project"
      "Environment" = "dev"
  }
}

variable "instance_type" {
  description = "type on the EC2 instance"
  type = string
  default = "t2.medium"
}

variable "my_key"{
  description = "my laptop's public key"
  type = string
  default = "Nazy'sMacKey"
}

variable "zone_name" {
  description = "Name of route 53 zone"
  type        = string
  default     = "nazydaisy.com."
}