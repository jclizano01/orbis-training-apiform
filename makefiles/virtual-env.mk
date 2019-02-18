.PHONY: create.venv \
		install.libs

## GENERAL ##
REQUIREMENTS_FILE = requirements.txt

create.venv: ## Crea el entorno virtual (virtualenv): make create.venv
	@echo "Create directory of virtualenv: ${VENV_DIR}"
	@docker container run \
		--workdir "/${APP_DIR}" \
		--rm \
		-it \
		-v "${PWD}/${VENV_DIR}":/${VENV_DIR} \
		-v "${PWD}/${APP_DIR}":/${APP_DIR} \
		--tty=false \
		${IMAGE_DEV}  \
		python3 -m venv /${VENV_DIR}

install.libs: ## Instala las librerias en el entorno virtual (virtualenv): make install.libs
	@echo "Install libraries from: ${REQUIREMENTS_FILE}"
	@docker container run \
		--workdir "/${APP_DIR}" \
		--rm \
		-it \
		-v "${PWD}/${VENV_DIR}":/${VENV_DIR} \
		-v "${PWD}/${APP_DIR}":/${APP_DIR} \
		--tty=false \
		${IMAGE_DEV}  \
		"/${VENV_DIR}/bin/pip" install -r ${REQUIREMENTS_FILE}

list.installed.lib: ## Listar librerias instaladas: make list.installed.lib
	@echo "List Installed libraries..."
	@docker container run \
		--workdir "/${APP_DIR}" \
		--rm \
		-it \
		-v "${PWD}/${VENV_DIR}":/${VENV_DIR} \
		-v "${PWD}/${APP_DIR}":/${APP_DIR} \
		--tty=false \
		${IMAGE_DEV}  \
		"/${VENV_DIR}/bin/pip" freeze