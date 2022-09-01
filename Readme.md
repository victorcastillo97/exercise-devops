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

USO
-------------
* La guia se hace en referencia al sistema ubuntu

#### Requerimientos
* Instalación de make -> apt install make
* Instalación de docker
* Instalación de aws-cli

#### 1. Almacenar los números y el resultado en una base de datos.

#### 2. Generar un bashero/yml que realice la compilación del backend de forma automática, ejecutando los test unitarios
Ejecutar:
* `make build.image.app.testing` #Para la construcción de la imagen para las pruebas
* `make unit.testing.app` #Ejecuta la pruebas en la aplicación

#### 3. Generar un DockerFile, que permita construir el build de una imagen de Nginx como reverse-proxy.
> ./docker/proxy/Dockerfile

#### 4.  Generar un DockerFile, que permita construir el build de una imagen con en backend.
> ./docker/app/Dockerfile

#### 5. Generar un DockerFile, que permita construir el build de una imagen personalizada con la base de datos.
> ./docker/bd/Dockerfile

#### 6. Generar un bashero/yml que realice la construcción automática de las imágenes mediante los archivos DockerFile respectivos.
Ejecutar:
* `make build.image.proxy`
* `make build.image.app`
* `make build.image.bd`

#### 7. Generar un bashero/yml que permita ejecutar las imágenes de Nginx y el Backend conectando a) Nginx ---> Backend ----> Base Datos
* Ejecutar: `make up`
* Detener: `make down`

#### 8. Continuous Integration: Realizar el despliegue mediante un toolchain de ALM por ejemplo Github/Gitlab/Bitbucket + Jenkins/Bamboo + Sonarqube
*No se abordo totalmente
En este caso se habia definido un pipeline para la ejecución automatica de las pruebas de las imagenes dockerizadas hasta ejecutar los servicios en el servidor de jenkins, a modo de prueba. Se usaria github como SCM.

![PruebaLocal](https://s3.us-west-2.amazonaws.com/victor.castillo/Captura+de+pantalla+de+2022-08-31+19-26-05.png)

#### 9. Continuous Delivery: Implementar Docker Registry en local o Cloud Provider (AWS, Azure, GCP, Ibm Cloud, Ali Cloud) para las imágenes de docker, Artifactory, Nexus Sonatype

* Ejecutar: `make ecr.login`, `make ecr.push.app`, `make ecr.push.bd`, `make ecr.push.proxy`

* Destruir: `make ecr.destroy.images`

* En este caso se realizo la subida de imagenes de docker hacia Amazon Elastic Container Registry (Amazon ECR)




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