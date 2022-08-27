include makefiles/ssh.mk

NAME_APP = exercise
APP_DIR = app
ENV = dev


PROJECT_NAME = ${NAME_APP}-${ENV}
IMAGE_NAME_APP = ${NAME_APP}:latest
IMAGE_NAME_BD = app.bd:latest
IMAGE_NAME_PROXY = proxy.bd:latest

build.image.app:
	@ docker build  \
		-f docker/app/Dockerfile \
		-t ${IMAGE_NAME_APP} \
		. \

build.image.bd:
	@ docker build  \
		-f docker/bd/Dockerfile \
		-t ${IMAGE_NAME_BD} \
		. \
		--no-cache

build.image.proxy:
	@ docker build  \
		-f docker/proxy/Dockerfile \
		-t ${IMAGE_NAME_PROXY} \
		. \
		--no-cache

run.app.local:
	@ docker run -d \
	-p 4000:4000 \
	${IMAGE_NAME} \

run.nginx.local:
	@ docker run -d \
	-p 9090:80 \
	${IMAGE_NAME_PROXY} \


run:
	@ docker run --rm -v app/conf/proxy.conf:/etc/nginx/conf.d/default.conf ngnix


