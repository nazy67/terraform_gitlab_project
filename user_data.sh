#!/bin/bash
echo test >> /tmp/testfile
whoami >> /tmp/testfile
pwd >> /tmp/testfile
yum install -y curl policycoreutils-python perl
curl -sS https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.rpm.sh | sudo bash 
yum install -y gitlab-ce