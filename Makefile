include makefiles/ssh.mk
include makefiles/ecr.mk

TYPE_APP 		= exercise
SERVICE_NAME 	= devops
ENV 			= dev
PROJECT_NAME 	= ${TYPE_APP}-${SERVICE_NAME}-${ENV}
SERVER_NUMBER_APP = 1


run.app.local:
	@ docker run -d \
	-p 4000:4000 \
	${IMAGE_NAME} \

run.nginx.local:
	@ docker run -d \
	-p 9090:4000 \
	${IMAGE_NAME_PROXY} \

run:
	@ docker run --rm -v app/conf/proxy.conf:/etc/nginx/conf.d/default.conf ngnix

up:
	@cd docker && docker compose up --scale api=${SERVER_NUMBER_APP}

down:
	@cd docker && docker compose down

