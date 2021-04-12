#!/bin/bash
yum install -y curl policycoreutils-python perl
curl -sS https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.rpm.sh | sudo bash 
yum install -y gitlab-ce