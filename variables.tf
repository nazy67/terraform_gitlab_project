variable "env" {
  description = "name of the env"
  default = "prod"
  type = string
}
variable "my_key"{
  description = "my laptop's public key"
  type = string
  default = "Nazy'sMacKey"
}

variable "zone_id" {
  description = "route 53 zone id"
  type = map
  default = {
    "us-east-1" = "Z35SXDOTRQ7X7K"
    "us-east-2" = "Z3AADJGX6KTTL2" 
  }
}

variable "zone_name" {
  description = "Name of route 53 zone"
  type        = string
  default     = "nazydaisy.com."
}

variable "public_zone" {
  description = "Route53 zone is public"
  type        = bool
  default     = true
}