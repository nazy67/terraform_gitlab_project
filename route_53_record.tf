data "aws_route53_zone" "my_record" {
  name        = var.zone_name
  zone_id     = var.zone_id
  public_zone = var.public_zone
} 

resource "aws_route53_record" "record" {
  zone_id = data.aws_route53_zone.my_record.zone_id
  name    = "www.${data.aws_route53_zone.my_record.name}"
  type    = "A"
  ttl     = "300"
  records = ["${aws_instance.project_ec2.public_ip}"]
}
