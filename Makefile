include .env

SSH_PORT=221

push:
	ssh -o StrictHostKeyChecking=no -p $(SSH_PORT) $(SSH_USER)@$(SSH_HOST) "rm -rf $(APP_PATH) && mkdir -p $(APP_PATH)"
	scp -o StrictHostKeyChecking=no -P $(SSH_PORT) -r $(APP_FILES) $(SSH_USER)@$(SSH_HOST):$(APP_PATH)
	ssh -o StrictHostKeyChecking=no -p $(SSH_PORT) $(SSH_USER)@$(SSH_HOST) "cd $(APP_PATH) \
		&& echo $(PRIVATE_KEY) | base64 -d >> $(APP_PATH)/.env \
		&& echo PRIVATE_REFRESH_KEY=$(PRIVATE_REFRESH_KEY) >> $(APP_PATH)/.env \
		&& echo DB_PASSWORD=$(DB_PASSWORD) >> $(APP_PATH)/.env \
		&& npm i && systemctl restart whatsup-api"