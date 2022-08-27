.PHONY: ecr.create \
		ecr.destroy \
		ecr.login \
		ecr.push \

REPOSITORY = app
ECR_REGION = us-west-2
IMAGE = exercise

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




ecr.push: envs
	@docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${ECR_REGION}.amazonaws.com/${IMAGE}:latest