include makefiles/ssh.mk
include makefiles/ecr.mk


TYPE_APP 		= exercise
SERVICE_NAME 	= devops
ENV 			= dev

PROJECT_NAME 	= ${TYPE_APP}-${SERVICE_NAME}-${ENV}
SERVER_NUMBER_APP = 1


#Params ECR
NAME_PROJECT_APP = app-${PROJECT_NAME}
NAME_PROJECT_BD = bd-${PROJECT_NAME}
NAME_PROJECT_PROXY = proxy-${PROJECT_NAME}

IMAGE_APP = ${NAME_PROJECT_APP}:latest
IMAGE_BD = ${NAME_PROJECT_BD}:latest
IMAGE_PROXY = ${NAME_PROJECT_PROXY}:latest

up: envs
	@export IMAGE_BD=${PATH_ECR}/${IMAGE_BD} && \
	export IMAGE_APP=${PATH_ECR}/${IMAGE_APP} && \
	export IMAGE_PROXY=${PATH_ECR}/${IMAGE_PROXY} && \
	cd docker && docker compose up --scale api=${SERVER_NUMBER_APP}

down: envs
	@export IMAGE_BD=${IMAGE_BD} && \
	export IMAGE_APP=${IMAGE_APP} && \
	export IMAGE_PROXY=${IMAGE_PROXY} && \
	cd docker && docker compose down

run.app.local:
	@ docker run -d \
	-p 4000:4000 \
	${IMAGE_NAME} \

run.nginx.local:
	@ docker run -d \
	-p 9090:4000 \
	${IMAGE_NAME_PROXY} \

