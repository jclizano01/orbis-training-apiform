.DEFAULT_GOAL := help

include ./makefiles/virtual-env.mk
include ./makefiles/function-lambda.mk

## GENERAL ##
OWNER            = orbis
SERVICE_NAME     = trainnig-apiform
APP_DIR          = "app"
VENV_DIR         = "venv"

## DEPLOY ##
ENV             ?= lab
DEPLOY_REGION   ?= ap-northeast-1
INFRA_BUCKET    ?= infraestructura.lab
SLACK_CHANNEL   ?= training-${ENV}-changelog

## RESULT_VARS ##
PROJECT_NAME    = ${OWNER}-${ENV}-${SERVICE_NAME}
IMAGE_DEV       = ${PROJECT_NAME}:dev


##################################################################
#### Development Commands
##################################################################

ssh: ## Conectar al container por el protocolo ssh: make ssh
	@docker container run \
		--workdir "/${APP_DIR}" \
		--rm \
		-it \
		-v "${PWD}/${VENV_DIR}":/${VENV_DIR} \
		-v "${PWD}/${APP_DIR}":/${APP_DIR} \
		${IMAGE_DEV} "/bin/zsh"

build: ## Construir imagen para development: make build
	@docker build \
		-f docker/dev/Dockerfile \
		-t $(IMAGE_DEV) \
		docker/dev/ \
		--no-cache


## Target Help ##

help:
	@printf "\033[31m%-22s %-59s %s\033[0m\n" "Target" "Help" "Usage"; \
	printf "\033[31m%-22s %-59s %s\033[0m\n" "------" "----" "-----"; \
	grep -hE '^\S+:.*## .*$$' $(MAKEFILE_LIST) | sed -e 's/:.*##\s*/:/' | sort | awk 'BEGIN {FS = ":"}; {printf "\033[32m%-22s\033[0m %-58s \033[34m%s\033[0m\n", $$1, $$2, $$3}'
