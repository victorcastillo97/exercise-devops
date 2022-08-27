include makefiles/ssh.mk

NAME_APP = exercise
APP_DIR = app
ENV = dev


PROJECT_NAME = ${NAME_APP}-${ENV}
IMAGE_NAME = ${NAME_APP}:latest

build.image:
	@ docker build  \
		-f docker/app/Dockerfile \
		-t ${IMAGE_NAME} \
		. \
		--no-cache

run.image.local:
	@ docker run -d \
	-p 4000:4000 \
	IMAGE_NAME