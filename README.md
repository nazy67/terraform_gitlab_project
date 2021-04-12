### Terraform GitLab Project on AWS EC2

Terraform configuration file provisions an EC2 instance with Security group in default VPC with User Data. Data source user_data.sh will install gitlab inside of the EC2 while booting. Also there's Route 53 record will be provisioned for EC2 instance it's for GitLab. 

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

GitLab doesn't run on Microsoft Windows, it was developed for Linux-based operating systems. For more information about Operating system requirements you can check out ```Requirements for installing GitLab``` in the  link below.

After choosing Operatiing system we need to choose ```Software version```:

- Ruby versions for GitLab 13.6 (Ruby 2.7 and later is required)
- Go versions (required Go version is 1.13)
- From GitLab 13.6 (Git 2.29.x and later is required)
- Starting from GitLab 12.9 (only support Node.js 10.13.0 or higher)
- GitLab 13.0 and later requires Redis version 4.0 or higher.

When we choose  hardware for GitLab there some ```Hardware requirements``` we have to follow. For installing GitLab it's important to as much free space as all our repositories combined to take. There few options of how we can manage our storage for GitLab, we can add more hard drives for flexibility, mounting hard drive when we need using logical volume management (LVM). We can also mount a volume that supports the nerwork file system (NFS) protocol, this storage can be located on a file server or on AWS Elastic Block storage (EBS) volume. 

The ```CPU requirements``` are depends on the numbers of users and expected workload, the minimum 4 cores of CPU supports 500 users, 8 cores supports 1000 users etc.

```RAM requirements``` the minimum must be 4GB RAM to support 500 users for more users more RAM. Also it's recommended to have at least 2GB swap memory on your server.

```Database```. PostgreSQL is the only supported database, which is bundled with Omnibus GitLab package. The server running PostgreSQL should have at least 5-10GB of storage available.

GitLab strongly advises to install GitLab runners in a different machine, it's not safe to install everything in a same machine for a security reasons, especially when you plan to use shell executor with GitLab runner. 

Web browsers supported by GitLab are: Mozilla Firefox, Google Chrome, Choromium, Apple Safari, Microsoft Edge.

Before we created a bash script for installing GitLab, all commands were run manually on CLI to check if commands given in official documentation are needed in our case. 
```
yum install -y curl policycoreutils-python perl

curl -sS https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.rpm.sh | sudo bash

yum install -y gitlab-ce
```

To prepare our machine first we install recommended utilities after that our command curl gets the script form the given link and passes it to bash to run it, "-s" - means silence and "-S" - means show error even when "-s" is used. Now we are ready to install commutinty edition of GitLab.

After the installing GitLab we need to configure our newly installed gitlab accound, for that we have to create a new user and password, because originally it was created with roots creadentials. 

## Useful links

[GitLab installation on CentOS 7](https://about.gitlab.com/install/?version=ce#centos-7)

[Installing GitLab on Amazon Web Services (AWS)](https://docs.gitlab.com/ee/install/aws/)

[What is GitLab and How To use It](https://www.simplilearn.com/tutorials/git-tutorial/what-is-gitlab#:~:text=GitLab%20is%20a%20web%2Dbased,management%20to%20monitoring%20and%20security)

[Requirements for installing GitLab](https://docs.gitlab.com/ee/install/requirements.html)

## Project is still in process...