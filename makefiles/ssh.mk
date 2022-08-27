
PATH_PEM = ngnix.pem
DNS_SERVER = ec2-35-90-161-39.us-west-2.compute.amazonaws.com

ssh.agent:
	@ eval `ssh-agent -s`

ssh.add.pem:
	@ ssh-add ${PATH_PEM}

ssh.config:
	@chmod 400 ${PATH_PEM}

ssh.connect:
	@ssh -i ${PATH_PEM} ec2-user@${DNS_SERVER}

config.ngnix:
	@ #!/bin/bash  \
	sudo yum update -y \
	sudo amazon-linux-extras install nginx1 -y \
	sudo systemctl enable nginx \
	sudo systemctl start nginx \