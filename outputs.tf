output "ec2_public_ip" {
  value = aws_instance.project_ec2.public_ip
}
output "sg_name" {
  value = aws_security_group.project_sg.name
}
#output "dns_name" {
#  value = aws_route53_record.my_dns.name
#}
