.PHONY: keypair.create \

SECRET_NAME_BD= $(PROJECT_NAME)-secret-database
REGION=us-west-2

secret.get:
	@aws secretsmanager describe-secret \
    --secret-id ${SECRET_NAME_BD} --region ${REGION}

generate.password:
	$(eval PASSWORD=$(shell aws secretsmanager get-random-password \
    --require-each-included-type \
    --password-length 20 --output text))

secret.create: generate.password
	@aws secretsmanager create-secret --name ${SECRET_NAME_BD} \
	--description "postgres" \
	--secret-string '{"password":$(PASSWORD)}' --region ${REGION}

