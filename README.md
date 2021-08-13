### Terraform GitLab Project on AWS EC2

Terraform configuration file provisions a GitLab server with Security group on default VPC's Public Subnet. With cloud-config we install GitLab, cloud-config files are special scripts designed to be run by the cloud-init process on the very first boot of a server. Also Route 53 record resource which will create A Record with my domain name for GitLab server. 

### Requirements

Gitlab supports (```Operating systems```) Linux Distributions such as:

- Ubuntu (16.04/18.04/20.04)
- Debian (9/10)
- CentOS (7/8)
- SUSE Linux Enterprise Server (12 SP2/12 SP5)
- Red Hat Enterprise Linux (please use the CentOS packages and instructions)

And doesn't support (we can still install Gitlab, but it's not supported):

- Arch Linux
- Fedora
- FreeBSD
- Gentoo
- macOS

GitLab doesn't run on Microsoft Windows, it was developed for Linux-based operating systems. For more information about Operating system requirements you can check out more in [Requirements for installing GitLab](https://docs.gitlab.com/ee/install/requirements.html).

After choosing Operating system we need to choose `Software version`:

- Ruby versions for GitLab 13.6 (Ruby 2.7 and later is required)
- Go versions (required Go version is 1.13)
- From GitLab 13.6 (Git 2.29.x and later is required)
- Starting from GitLab 12.9 (only support Node.js 10.13.0 or higher)
- GitLab 13.0 and later requires Redis version 4.0 or higher.

When we choose  hardware for GitLab there some `Hardware requirements` we have to follow. For installing GitLab it's important to have as much free space as all our repositories combined to take. There few options of how we can manage our storage for GitLab, we can add more hard drives for flexibility, mounting hard drive when we need using logical volume management (LVM). We can also mount a volume that supports the nerwork file system (NFS) protocol, this storage can be located on a file server or on AWS Elastic Block storage (EBS) volume. 

The `CPU requirements` are depends on the numbers of users and expected workload, the minimum 4 cores of CPU supports 500 users, 8 cores supports 1000 users etc.

`RAM requirements` the minimum must be 4GB RAM to support 500 users for more users more RAM. Also it's recommended to have at least 2GB swap memory on your server.

`Database`. PostgreSQL is the only supported database, which is bundled with `Omnibus GitLab package`. The server running PostgreSQL should have at least 5-10GB of storage available.

GitLab strongly advises to install GitLab runners in a different machine, it's not safe to install everything in a same machine for a security reasons, especially when you plan to use shell executor with GitLab runner. 

Web browsers supported by GitLab are: Mozilla Firefox, Google Chrome, Choromium, Apple Safari, Microsoft Edge.

Before we created a cloud-config script for installing GitLab, all commands were run manually on CLI to check if commands given in official documentation are needed for our case.

```
#cloud-config

# boot commands
bootcmd:
- sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config
- setenforce 0

# update repos
repo_update: true
repo_upgrade: all

# update packages
package_upgrade: true
packages:
- epel-release
- wget
- certbot
- python2-certbot-nginx
- curl 
- policycoreutils-python 
- perl

# run commands
runcmd:
- /usr/bin/firewall-offline-cmd --add-port=22/tcp
- sudo hostnamectl set-hostname gitlab
- curl -sS https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.rpm.sh | sudo bash 
- sudo EXTERNAL_URL="https://gitlab.nazydaisy.com" yum install -y gitlab-ce
- sudo firewall-cmd --zone=public --permanent --add-port=80/tcp
- sudo firewall-cmd --zone=public --permanent --add-port=443/tcp
- sudo firewall-cmd --zone=public --permanent --add-service=https
- sudo firewall-cmd --permanent --add-service=http
- sudo firewall-cmd --permanent --add-service=https
- sudo firewall-cmd --reload
- sudo systemctl daemon-reload
- sudo setsebool -P httpd_can_network_connect 1
- sudo echo "nginx['custom_gitlab_server_config'] = \"location /.well-known/acme-challenge/ {\\n root /var/opt/gitlab/nginx/www/; \\n}\\n\"" >> /etc/gitlab/gitlab.rb
- sudo gitlab-ctl renew-le-certs
- sudo gitlab-ctl reconfigure
```

Prior to installation of GitLab it is recommended to install utilities, after that our command curl gets the script from a given link and passes it to  bash to run it, where 
- `s`  means silence
- `S`  means show error even when "-s" is used.
 
Now we are ready to install community edition of GitLab.

After installing GitLab we need to configure our newly installed GitLab accound, for that we have to create a new user and password, because originally server was created with roots credentials. 

To follow up on requirement the next options were chosen:

- image id        = ami-0affd4508a5d2481b  # CentOS 7
- instance type   = is t2.medium  (where CPU is 2GB and RAM 4GB memory)
- ebs root volume = 8GB /dev/xvda (by default) 

On AWS official documentation for the instance type AWS recommends at least `c5.xlarge` to run a GitLab, which is sufficient to accomodate 100 users. Also in the link below you can find the AWS provided image ids.

It takes arount 10-12 minutes to spin up the instance, after that we need to retrive admin users password by running next commands:

```
sudo gitlab-rake "gitlab:password:reset"
Enter username: root
Enter user password: password123
Confirm userpassword: password123
```

Or by default, Omnibus GitLab automatically generates a password for the initial administrator user account (root) and stores it to /etc/gitlab/initial_root_password for at least 24 hours. For security reasons, after 24 hours, this file is automatically removed by the first gitlab-ctl reconfigure.

Renewing certificate:

Manual Let’s Encrypt Renewal

Renew Let’s Encrypt certificates manually using one of the following commands:
```
sudo gitlab-ctl renew-le-certs
```

You can test automatic renewal for your certificates by running this command:
```
sudo certbot renew --dry-run
```
Or you can simply use the script 
```
sudo vi /etc/cron.daily/letsencrypt-renew
```
```
#!/bin/sh
if certbot renew > /var/log/letsencrypt/renew.log 2>&1 ; then
   nginx -s reload
fi
exit
```
```
sudo chmod +x /etc/cron.daily/letsencrypt-renew
```
```
sudo crontab -e
```
```
01 02,14 * * * /etc/cron.daily/letsencrypt-renew
```


## Useful links

1. [GitLab installation on CentOS 7](https://about.gitlab.com/install/?version=ce#centos-7)

2. [Installing GitLab on Amazon Web Services (AWS)](https://docs.gitlab.com/ee/install/aws/)

3. [Install GitLab](https://docs.gitlab.com/ee/install/aws/#install-gitlab)

4. [GitLab CE images provided by AWS](https://console.aws.amazon.com/ec2/v2/home?region=us-east-1#Images:visibility=public-images;ownerAlias=782774275127;search=GitLab%20CE;sort=desc:name)

5. [What is GitLab and How To use It](https://www.simplilearn.com/tutorials/git-tutorial/what-is-gitlab#:~:text=GitLab%20is%20a%20web%2Dbased,management%20to%20monitoring%20and%20security)

6. [Requirements for installing GitLab](https://docs.gitlab.com/ee/install/requirements.html)

7. [firewall-cmd](https://firewalld.org/documentation/man-pages/firewall-cmd.html)

8. [What is SELinux?](https://www.redhat.com/en/topics/linux/what-is-selinux)