### Gitlab EBS Volume
resource "aws_ebs_volume" "gitlab_ebs" {
   availability_zone = var.ebs_az
   size              = var.ebs_size
   encrypted         = true
   tags = var.glab_ebs_tags
}

### GitLab EBS Volume Attachment
resource "aws_volume_attachment" "ebs_attachment" {
   depends_on  = [aws_ebs_volume.gitlab_ebs]
   device_name = "/dev/xvdf"
   volume_id   =  aws_ebs_volume.gitlab_ebs.id
   instance_id = aws_instance.gitlab_server.id
}