NAMESPACE = myrtea
APP = docs
TAG ?= v0.0.0
BUILD ?= 0
BUILD_DATE = $(shell date +%FT%T)
TARGET_ENV ?= local

BUILD_CONFIGURATION ?= local

APP_NAME = $(NAMESPACE)-$(APP)
ifeq ("$(TARGET_ENV)", "master")
  DOCKER_IMAGE = github.com/myrteametrics/$(APP_NAME):$(TAG)
else
  DOCKER_IMAGE = github.com/myrteametrics/$(APP_NAME):$(TAG)-$(TARGET_ENV)
endif

.DEFAULT_GOAL := help
.PHONY: help
help:
	@echo "===  Myrtea build & deployment helper ==="
	@echo "* Don't forget to check all overridable variables"
	@echo ""
	@echo "The following commands are available :"
	@grep -E '^\.PHONY: [a-zA-Z_-]+.*?## .*$$' $(MAKEFILE_LIST) | cut -c9- | awk 'BEGIN {FS = " ## "}; {printf "\033[36m%-40s\033[0m %s\n", $$1, $$2}'

.PHONY: install ## Download all dependencies
install:
	apk add --no-cache gcc musl-dev
	pip install --no-cache-dir \
		mkdocs \
		mkdocs-material \
		mkdocs-minify-plugin \
		pymdown-extensions \
		pygments

.PHONY: lint ## Lint the code
lint:
	# MD lint - todo

.PHONY: build ## Build the executable (linux by default)
build:
	mkdocs build --clean

.PHONY: deploy
deploy:
	mkdocs gh-deploy --clean

.PHONY: run ## Run the executable
run:
	mkdocs serve

# .PHONY: docker-build ## Build the executable and docker image (using multi-stages build)
# docker-build:
# 	docker build -t $(DOCKER_IMAGE) -f Dockerfile .

.PHONY: docker-build-local ## Build the docker image (please ensure you used "make build" before this command)
docker-build-local:
	docker build -t $(DOCKER_IMAGE) -f local.Dockerfile .

.PHONY: docker-run ## Run the docker image
docker-run:
	docker run -d --name $(APP_NAME) -p $(PORT):$(TARGET_PORT) $(DOCKER_IMAGE)

.PHONY: docker-stop ## Stop the docker image
docker-stop:
	docker stop $(APP_NAME)

.PHONY: docker-push ## Push the docker image to hub.docker.com
docker-push:
	docker push $(DOCKER_IMAGE)

.PHONY: docker-save ## Export the docker image to a tar file
docker-save:
	docker save --output $(APP_NAME)-$(TARGET_ENV).tar $(DOCKER_IMAGE)

.PHONY: docker-clean ## Delete the docker image from the local cache
docker-clean:
	docker image rm $(DOCKER_IMAGE) $(docker images -f dangling=true -q) || true