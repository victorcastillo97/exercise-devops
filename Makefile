include makefiles/ssh.mk

NAME_APP = exercise
APP_DIR = app
ENV = dev


PROJECT_NAME = ${NAME_APP}-${ENV}
IMAGE_NAME_APP = ${NAME_APP}:latest
IMAGE_NAME_BD = app.bd:latest

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

run.image.local:
	@ docker run -d \
	-p 4000:4000 \
	${IMAGE_NAME} \
