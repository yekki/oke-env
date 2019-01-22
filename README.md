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

	

