### Gitlab security group

resource "aws_security_group" "gitlab_sg" {
  name        = "gitlab_sg"
  description = "allow inbound traffic"
  tags        = var.glab_sg_tags
}

### GitLab security group ingress rules

resource "aws_security_group_rule" "ingress" {
  for_each          = var.ingress
  type              = "ingress"
  protocol          = each.value.protocol
  from_port         = each.value.from
  to_port           = each.value.to
  description       = each.value.desc
  cidr_blocks       = [each.value.cidr]
  security_group_id = aws_security_group.gitlab_sg.id
}

### GitLab security group egress rules

resource "aws_security_group_rule" "egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.gitlab_sg.id
}