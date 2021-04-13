variable "tags" {
  type = map(any)
}

variable "env" {
  type = string
  description = "environment"
}

variable "instance_type" {
  description = "type on the EC2 instance"
  type        = string
}

variable "my_key" {
  description = "local laptop's public key"
  type        = string

}

variable "zone_name" {
  description = "Name of route 53 zone"
  type        = string
}