.PHONY: ecr.login \
		ecr.push.app \
		ecr.push.bd \
		ecr.push.proxy \
		ecr.destroy.images

ECR_REGION = us-west-2
PROFILE = default

envs:
	$(eval AWS_ACCOUNT_ID = $(shell aws sts get-caller-identity --query "Account" --output text))
	$(eval PATH_ECR = ${AWS_ACCOUNT_ID}.dkr.ecr.${ECR_REGION}.amazonaws.com)

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
	@aws ecr get-login-password --region ${ECR_REGION} --profile ${PROFILE} | \
	docker login --username AWS --password-stdin \
	${PATH_ECR}


ecr.tag.image: envs
	@docker tag ${IMAGE} ${PATH_ECR}/${IMAGE}

ecr.push: envs
	@docker push ${PATH_ECR}/${IMAGE}

ecr.push.app:
	@ export REPOSITORY=${NAME_PROJECT_APP} && make ecr.create && \
		make ecr.tag.image IMAGE=${IMAGE_APP} && \
		make ecr.push IMAGE=${IMAGE_APP}

ecr.push.bd:
	@ export REPOSITORY=${NAME_PROJECT_BD} && make ecr.create && \
		make ecr.tag.image IMAGE=${IMAGE_BD} && \
		make ecr.push IMAGE=${IMAGE_BD}

ecr.push.proxy:
	@ export REPOSITORY=${NAME_PROJECT_PROXY} && make ecr.create && \
		make ecr.tag.image IMAGE=${IMAGE_PROXY} && \
		make ecr.push IMAGE=${IMAGE_PROXY}

ecr.destroy.images:
	@for number in ${NAME_PROJECT_APP} ${NAME_PROJECT_BD} ${NAME_PROJECT_PROXY} ; do \
        export REPOSITORY=$$number && make ecr.destroy ; \
    done