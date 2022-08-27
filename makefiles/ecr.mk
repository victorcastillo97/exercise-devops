.PHONY: ecr.create \
		ecr.destroy \
		ecr.login \
		ecr.push \


NAME_APP = app-${PROJECT_NAME}
NAME_BD = bd-${PROJECT_NAME}
NAME_PROXY = proxy-${PROJECT_NAME}

IMAGE_APP = ${NAME_APP}:latest
IMAGE_BD = ${NAME_BD}:latest
IMAGE_PROXY = ${NAME_PROXY}:latest

ECR_REGION = us-west-2

envs:
	$(eval AWS_ACCOUNT_ID = $(shell aws sts get-caller-identity --query "Account" --output text))

ecr.consult:
	@aws ecr describe-repositories --repository-names ${REPOSITORY} --region $(ECR_REGION)

ecr.destroy: COMMAND=$(shell output=$$(make ecr.consult 2>&1); \
			if [ $$? -ne 0 ]; then if echo $${output} | grep -q RepositoryNotFoundException; then \
			echo "The repository not exist"; else >&2 echo $${output}; fi \
			else  aws ecr delete-repository --repository-name ${REPOSITORY} --region $(ECR_REGION) --force && \
			echo "The repository and images have been eliminated."; fi)

ecr.destroy:
	@echo $(COMMAND)

ecr.create: COMMAND=$(shell output=$$(make ecr.consult 2>&1); \
			if [ $$? -ne 0 ]; then if echo $${output} | grep -q RepositoryNotFoundException; then \
			aws ecr create-repository --repository-name ${REPOSITORY} --region $(ECR_REGION) --image-tag-mutability IMMUTABLE --image-scanning-configuration scanOnPush=false && echo "Repository created"; else >&2 echo ${output}; fi \
			else  echo "The repository ${REPOSITORY} exist."; fi)

ecr.create:
	@echo $(COMMAND)

ecr.login: envs
	@aws ecr get-login-password --region ${ECR_REGION} --profile default | \
	docker login --username AWS --password-stdin \
	${AWS_ACCOUNT_ID}.dkr.ecr.${ECR_REGION}.amazonaws.com


build.image.app:
	@ docker build  \
		-f docker/app/Dockerfile \
		-t ${IMAGE_APP} \
		. \
		--no-cache

build.image.bd:
	@ docker build  \
		-f docker/bd/Dockerfile \
		-t ${IMAGE_BD} \
		. \
		--no-cache

build.image.proxy:
	@ docker build  \
		-f docker/proxy/Dockerfile \
		-t ${IMAGE_PROXY} \
		docker/proxy/ \
		--no-cache

ecr.tag.image: envs
	@docker tag ${IMAGE} ${AWS_ACCOUNT_ID}.dkr.ecr.${ECR_REGION}.amazonaws.com/${IMAGE}

ecr.push: envs
	@docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${ECR_REGION}.amazonaws.com/${IMAGE}

ecr.push.app:
	@ export REPOSITORY=${NAME_APP} && make ecr.create && \
		make ecr.tag.image IMAGE=${IMAGE_APP} && \
		make ecr.push IMAGE=${IMAGE_APP}

ecr.push.bd:
	@ export REPOSITORY=${NAME_BD} && make ecr.create && \
		make ecr.tag.image IMAGE=${IMAGE_BD} && \
		make ecr.push IMAGE=${IMAGE_BD}

ecr.push.proxy:
	@ export REPOSITORY=${NAME_PROXY} && make ecr.create && \
		make ecr.tag.image IMAGE=${IMAGE_PROXY} && \
		make ecr.push IMAGE=${IMAGE_PROXY}

ecr.destroy.images:
	@for number in ${NAME_APP} ${NAME_BD} ${NAME_PROXY} ; do \
        export REPOSITORY=$$number && make ecr.destroy ; \
    done