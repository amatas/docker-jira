# Make some pertinent variables from the application manifest be available for use with make 
# targets and the Dockerfile
include env.mk

all:
	@echo "Usage: make [image|stop|clean|test]" 
	@echo ""
	@echo "    image   Creates image based on app.yml parameters"
	@echo "    stop    Stops container"
	@echo "    clean   Deletes temporary files and related images"
	@echo "    test    Runs Ansible test.yml playbook inside container"
	@echo ""


image:
	@echo "Building image..."
	@echo ""

	rm -f Dockerfile
	cat Dockerfile.template | envsubst > Dockerfile
	sudo docker build -t $(APP_DOCKER_IMAGE):$(APP_VERSION) .
	sudo docker tag -f $(APP_DOCKER_IMAGE):$(APP_VERSION) $(APP_DOCKER_IMAGE):latest
	rm -f Dockerfile


stop:
	@echo "Stopping container..."
	@echo ""

	sudo docker rm -f -v $(APP_NAME); true


clean: stop 
	@echo "Deleting build artifacts..."
	@echo ""

	rm -f Dockerfile
	sudo docker rmi -f $(APP_DOCKER_IMAGE):$(APP_VERSION); true
	sudo docker rmi -f $(APP_DOCKER_IMAGE):latest; true


test:
	@echo "Starting container to run tests..."
	@echo ""

	sudo -E docker run -i -t --name="$(APP_NAME)" \
	-e DB_SERVICE_ADDRESS=$(DB_SERVICE_ADDRESS) \
	-e APP_DB_NAME=$(APP_DB_NAME) \
	-e APP_DB_USERNAME=$(APP_DB_USERNAME) \
	-e APP_DB_PASSWORD=$(APP_DB_PASSWORD) \
	-e APP_MEMORY_LIMIT=$(APP_MEMORY_LIMIT) \
	-e APP_TCP_PORT=$(APP_TCP_PORT) \
	-e APP_TEST_HTTP_ENDPOINT=$(APP_TEST_HTTP_ENDPOINT) \
	-e APP_TEST_HTTP_STATUS_CODE=$(APP_TEST_HTTP_STATUS_CODE) \
	-e APP_TEST_STRING="$(APP_TEST_STRING)" \
	$(APP_DOCKER_IMAGE) \
	ansible-playbook /srv/ansible/container.yml --tags "deploy,test"

