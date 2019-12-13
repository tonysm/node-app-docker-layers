.EPHONY: build

DOCKER_IMAGE := tonysm/node-app-docker
DOCKER_IMAGE_VERSION := 2.0.0

build:
	docker build -t $(DOCKER_IMAGE):$(DOCKER_IMAGE_VERSION) .
