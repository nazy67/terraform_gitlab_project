#!/bin/bash
#echo test >> /tmp/testfile
#whoami >> /tmp/testfile
#pwd >> /tmp/testfile
sudo yum install -y curl policycoreutils-python openssh-server openssh-clients perl
sudo systemctl enable sshd
sudo systemctl start sshd
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --permanent --add-service=https
sudo systemctl reload firewalld
curl -sS https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.rpm.sh | sudo bash
sudo EXTERNAL_URL="https://www.nazydaisy.com" yum install -y gitlab-ce
