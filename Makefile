.DEFAULT_GOAL := help

include makefiles/ct.mk
include makefiles/ecr.mk
include makefiles/secret.mk


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

up: ## Deploy of the app, database and reverse proxy.: make up
	@export IMAGE_BD=${IMAGE_BD} && \
	export IMAGE_APP=${IMAGE_APP} && \
	export IMAGE_PROXY=${IMAGE_PROXY} && \
	cd docker && docker compose up -d --scale api=${SERVER_NUMBER_APP}

down: ## Destroy of the app, database and reverse proxy.: make down
	@export IMAGE_BD=${IMAGE_BD} && \
	export IMAGE_APP=${IMAGE_APP} && \
	export IMAGE_PROXY=${IMAGE_PROXY} && \
	cd docker && docker compose down


build.image.app.testing:
	@ docker build  \
		-f docker/app/Dockerfile \
		-t ${NAME_PROJECT_APP}:test \
		--target test \
		.

unit.testing.app:
	@ docker run --rm  ${NAME_PROJECT_APP}:test

