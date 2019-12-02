SHELL := /bin/bash

.PHONY: all
all: build_docker_dev lint_docker test_docker run_docker

# Docker image without development packages
.PHONY: build_docker_release
build_docker_release:
	@echo "Building Release Docker image..."
	docker build -f ./Dockerfile -t python_template:latest .

# Development Docker images containing additional packages for testing and quality checks
.PHONY: build_docker_dev
build_docker_dev: build_docker_release
	@echo "Building Dev Docker image..."
	docker build -f ./Dockerfile_dev -t python_template_dev:latest .

.PHONY: test_docker
test_docker: build_docker_dev
	@echo "Running tests..."
	docker run -t \
		-v `pwd`/test-results/:/test-results/:Z \
		python_template_dev:latest \
		bash -c "cd /tests; pytest"

.PHONY: lint_docker
lint_docker: build_docker_dev
	@echo "Running linter..."
	docker run -t \
		-v `pwd`/test-results/:/test-results/:Z \
		python_template_dev:latest \
		bash -c "flake8 --config=/.flake8 /app"

.PHONY: run_docker
run_docker: build_docker_release
	@echo "Running main app..."
	docker run python_template:latest

.PHONY: clean
clean:
# Delete image from images list
	docker rmi -f python_template:latest
	docker rmi -f python_template_dev:latest
	rm -fr ./test-results/*
