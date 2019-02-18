.PHONY: package.function \
		update.function
		delete.function \
		upload.function.bucket \
		delete.function.bucket

## VARS ##
LAMBDA_FUNCTION_NAME  = ${PROJECT_NAME}
SOURCE_BUCKET_NAME    = ${INFRA_BUCKET}
SOURCE_BUCKET_KEY     = build/lambda/${ENV}/${LAMBDA_FUNCTION_NAME}.zip

## FUNCTIONS ##

define create_zip_site_packages
 	@cd ${PWD}/${VENV_DIR}/lib/python3.6/site-packages && \
	 zip -r9 $(LAMBDA_FUNCTION_NAME).zip *
endef

define move_zip_site_packages
	@mv ${PWD}/${VENV_DIR}/lib/python3.6/site-packages/$(LAMBDA_FUNCTION_NAME).zip ./
endef

define add directory app to the zip
	@echo "Add files app to package archive: $(LAMBDA_FUNCTION_NAME).zip"
	@cd app && \
	 zip -gr9 $(PWD)/$(LAMBDA_FUNCTION_NAME).zip *
endef

## TARGETS ##

package.function: ## Empaqueta la funcion lambda en un archivo zip: make create.lambda.zip
	@echo "Create package archive of lambda..."
	$(call create_zip_site_packages)
	$(call move_zip_site_packages)
	$(call add directory app to the zip)

update.function: ## Actualizar funcion lambda: make update.function	
	@echo "Update function code lambda..."
	aws lambda update-function-code \
	--function-name $(LAMBDA_FUNCTION_NAME) \
	--zip-file fileb://$(LAMBDA_FUNCTION_NAME).zip \
	--region $(DEPLOY_REGION)
	
delete.function: ## Elimina el zip de la funcion lambda generada: make delete.funcion
	@echo "Delete package archive of function lambda"
	@if [ -f $(LAMBDA_FUNCTION_NAME).zip ]; then rm $(LAMBDA_FUNCTION_NAME).zip; fi

upload.function.bucket: ## Sube la funcion lambda al bucket s3: make upload.function.bucket
	@echo "Upload function lambda in s3"
	@aws s3 \
	 cp ./$(LAMBDA_FUNCTION_NAME).zip \
	 s3://$(SOURCE_BUCKET_NAME)/$(SOURCE_BUCKET_KEY)

delete.function.bucket: ## Elimina la funcion lambda de s3: make delete.function.bucket
	@echo "Delete function lambda in s3"
	@aws s3 \
	 rm s3://${SOURCE_BUCKET_NAME}/$(SOURCE_BUCKET_KEY)