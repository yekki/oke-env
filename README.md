# Prepare VM ( Ignore it if you have Linux 7 environment)
## Install virtualbox

https://www.virtualbox.org

PS: Make sure install VirtualBox Extension Pack

## Install vagrant

https://www.vagrantup.com/downloads.html

## Install vagrant proxy plugin

	vagrant plugin install vagrant-proxyconf

PS: Make sure set http_proxy && https_proxy environment variables firstly if needed.

## Start VM

	vagrant up


## Change Password

	vagrant ssh
	sudo passwd root


## Install Desktop

	yum groupinstall 'Server with GUI'
	startx

# Install Python
## Install packages

	sudo yum install openssl-devel bzip2-devel sqlite-devel git

## Install pyenv

	git clone https://github.com/pyenv/pyenv.git ~/.pyenv

	echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bash_profile

	echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bash_profile

	echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.bash_profile

	source ~/.bash_profile


## Install python
	
	pyenv install --list

	pyenv install 3.5.6

	pyenv global 3.5.6

# oci-cli installation && configuration

## Install oci-cli

	pip install oci-cli
	oci --version

## Config oci-cli

	oci setup config

## Testing

	oci iam region list

PS:

If following error occurs:

	WARNING: Permissions on /root/.certs/apikey.pem are too open

modify cert permission with:
	
	chmod 400 /root/.certs/apikey.pem


# kubectl installation && configuration

## Install kubectl

	cat <<EOF > /etc/yum.repos.d/kubernetes.repo
	[kubernetes]
	name=Kubernetes
	baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
	enabled=1
	gpgcheck=1
	repo_gpgcheck=1
	gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
	EOF


	yum install -y kubectl


# Install kubernetes by terraform-kubernetes-installer

## Preparation

Install terraform:

	https://www.terraform.io/downloads.html

Clone installer:

	git clone https://github.com/oracle/terraform-kubernetes-installer

## Modify config files

variables.tf:
	
	variable "ssh_public_key_openssh" {
	  description = "SSH public key in OpenSSH authorized_keys format for instances (generated if left blank)"
	  type        = "string"
	  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDK47ExQdjngF4l85VDBKJmZ+V4ofHEROlwxmWyhqocPpfczfM8xpgYivEBUaiXJnjjrrWTuQ6xiBSUW+y8mra+50TDFMwxMNv939c0Ogba8GKIKaM5JGFdAwFGUtiwBiD2TfEYWMylM3gHsrphNQ5qxAXKeyuIcIO+2sijtsAquxdzvWj1gjnjHQ2zK/EQuhcRHboXLNHr2vzcIsU3+14NaHj8L4GMqsxQPqHXclYJ50vERQ9DZMJZ1PscfPx8ujNyCYW9I4TXwWX86IZPDdhZ8eTSqKqSShhNYrM1Kui2GWNBPMW6Pg7/RUnKlnWwxTv+56/EPOY/qb84AWj2XP3j gniu@gniu-ipro"
	}
	
	variable "ssh_private_key" {
	  description = "SSH private key used for instances (generated if left blank)"
	  type        = "string"
	  default     = "/Users/gniu/.certs/sshkey"
	}


terraform.tfvars

	tenancy_ocid = "ocid1.tenancy.oc1..xxxx"
	compartment_ocid = "ocid1.compartment.oc1..xxx"
	fingerprint = "71:4c:01:08:52:35:0f:3d:3e:08:25:69"
	private_key_path = "/Users/gniu/.certs/apikey.pem"
	user_ocid = "ocid1.user.oc1..xxxx"
	region = "us-phoenix-1"

	etcdShape = "VM.Standard2.1"
	k8sMasterShape = "VM.Standard2.1"
	k8sWorkerShape = "VM.Standard2.1"

	etcdAd1Count = "0"
	etcdAd2Count = "1"
	etcdAd3Count = "0"

	k8sWorkerAd1Count = "0"
	k8sWorkerAd2Count = "0"
	k8sWorkerAd3Count = "1"

	etcdLBShape = "400Mbps"
	k8sMasterLBShape = "400Mbps"

	etcd_ssh_ingress = "0.0.0.0/0"

	master_ssh_ingress = "0.0.0.0/0"
	master_https_ingress = "0.0.0.0/0"
	master_nodeport_ingress = "0.0.0.0/0"

	worker_nodeport_ingress = "0.0.0.0/0"
	worker_ssh_ingress = "0.0.0.0/0"


## Create k8s cluster

	terraform init
	terraform plan
	terraform apply

## Testing

~/.bash_profile

	export KUBECONFIG=/Users/gniu/Workspaces/terraform-kubernetes-installer/generated/kubeconfig

Start proxy:

	kubectl proxy

Access url with your web browser:

	http://localhost:8001/api/v1/namespaces/kube-system/services/kubernetes-dashboard/proxy/#!/overview?namespace=default


