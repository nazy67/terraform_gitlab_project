### GitLab server outputs
output "glab_public_ip" {
  value = aws_instance.gitlab_server.public_ip
}
output "glab_id" {
  value = aws_instance.gitlab_server.id
}
output "glab_sg_id" {
  value = aws_security_group.gitlab_sg.id
}

### GitLab route 53 outputs
output "dns_name" {
  value = aws_route53_record.record.name
}
output "public_dns" {
  value = aws_instance.gitlab_server.public_dns
}