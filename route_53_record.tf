### Gitlab A Record 
resource "aws_route53_record" "record" {
  zone_id = data.aws_route53_zone.my_zone.zone_id
  name    = "gitlab.${data.aws_route53_zone.my_zone.name}"
  type    = "A"
  ttl     = "300"
  records = [aws_instance.gitlab_server.public_ip]
}