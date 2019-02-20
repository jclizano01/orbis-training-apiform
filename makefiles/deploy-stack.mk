.PHONY: stack.deploy \
        stack.delete

## VARS ##
STACK_NAME          ?= ${PROJECT_NAME}
TEMPLATE_FILE       = ./cloudformation/sam.yaml
LAMBDA_BUCKET_NAME  = ${INFRA_BUCKET}
LAMBDA_BUCKET_KEY   = build/lambda/${ENV}/${PROJECT_NAME}.zip
DEPLOY_USER_NAME    = "jeanlizano"

## TARGETS ##

stack.deploy: ## Desplegar stack cloudformation: make deploy.stack
	@echo "Deploy stack cloudformation..."
	@aws cloudformation deploy \
        --template-file $(TEMPLATE_FILE) \
        --stack-name $(STACK_NAME) \
        --parameter-overrides \
            Owner=$(OWNER) \
            ServiceName=$(SERVICE_NAME) \
            Environment=$(ENV) \
            UserName=$(DEPLOY_USER_NAME) \
            LambdaBucketName=$(LAMBDA_BUCKET_NAME) \
            LambdaBucketKey=$(LAMBDA_BUCKET_KEY) \
        --capabilities CAPABILITY_NAMED_IAM \
        --region $(DEPLOY_REGION)

stack.delete: ## Eliminar stack cloudformation: make delete.stack
	@echo "Delete stack cloudformation: $(STACK_NAME) in region: $(DEPLOY_REGION)"
	@aws cloudformation delete-stack \
        --stack-name $(STACK_NAME) \
        --region $(DEPLOY_REGION)