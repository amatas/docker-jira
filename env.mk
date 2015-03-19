#EXECUTABLES = ls shyaml
#K := $(foreach exec,$(EXECUTABLES), \
#	$(if $(shell type $(exec))," is ",$(error "No $(exec) in PATH)))


export APP_NAME := $(shell cat app.yml | shyaml get-value APP_NAME)
export APP_VERSION := $(shell cat app.yml | shyaml get-value APP_VERSION)
export APP_TCP_PORT := $(shell cat app.yml | shyaml get-value APP_TCP_PORT)
export APP_DOCKER_IMAGE := $(shell cat app.yml | shyaml get-value APP_DOCKER_IMAGE)
export APP_DOCKER_BASE_IMAGE := $(shell cat app.yml | shyaml get-value APP_DOCKER_BASE_IMAGE)
export APP_TEST_HTTP_ENDPOINT := $(shell cat app.yml | shyaml get-value APP_TEST_HTTP_ENDPOINT)
export APP_TEST_HTTP_STATUS_CODE := $(shell cat app.yml | shyaml get-value APP_TEST_HTTP_STATUS_CODE)
export APP_TEST_STRING := $(shell cat app.yml | shyaml get-value APP_TEST_STRING)

export APP_DB_NAME := $(shell printenv APP_DB_NAME)
export APP_DB_USERNAME := $(shell printenv APP_DB_USERNAME)
export APP_DB_PASSWORD := $(shell printenv APP_DB_PASSWORD)

export DOCKER_EMAIL := $(shell printenv DOCKER_EMAIL)
export DOCKER_USERNAME := $(shell printenv DOCKER_USERNAME)
export DOCKER_PASSWORD := $(shell printenv DOCKER_PASSWORD)

export DOCKER_REGISTRY = https://index.docker.io/v1/

# TODO maybe this should be more generic like DB_SERVICE_ADDRESS
export POSTGRESQL_SERVICE_ADDRESS := $(shell printenv POSTGRESQL_SERVICE_ADDRESS)

