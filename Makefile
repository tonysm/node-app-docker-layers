.EPHONY: build

DOCKER_IMAGE := tonysm/node-app-docker
DOCKER_IMAGE_VERSION := 1.0.0

build:
	docker build -t $(DOCKER_IMAGE):$(DOCKER_IMAGE_VERSION) .
