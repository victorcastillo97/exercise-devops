Exercise-Devops
====================

Requirementos
-------------
* Docker
* Docker-compose
* Cmake
* Aws-cli

Help
----
* make

Comandos
--------
```console
Target                     Help                                                        Usage
------                     ----                                                        -----
build.image.app            Build image for application.                                make build.image.app
build.image.bd             Build image for database postgres.                          make build.image.bd
build.image.proxy          Build image for reverse proxy.                              make build.image.proxy
down                       Destroy of the app, database and reverse proxy.             make down
ecr.consult                Query if there is a repository ECR.                         make ecr.consult
ecr.create                 Create a repository ECR in AWS.                             make ecr.create
ecr.destroy                Destroy of the repository ECR in AWS.                       make ecr.destroy
ecr.destroy.images         Destroy all ECR's and its images.                           make ecr.destroy.images
ecr.login                  Login for the repository ECR in AWS.                        make ecr.login
ecr.push                   Allows to upload dockerized image to repository ECR.        make ecr.push
ecr.push.app               Create the ECR repository and host the image there for app.  make ecr.push.app
ecr.push.bd                Create the ECR repository and host the image there for database.  make ecr.push.bd
ecr.push.proxy             Create the ECR repository and host the image there for proxy.  make ecr.push.proxy
ecr.tag.image              Tag of image dockerized for the repository ECR.             make ecr.tag.image
up                         Deploy of the app, database and reverse proxy.              make up

```