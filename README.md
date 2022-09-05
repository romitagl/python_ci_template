# Description

This project can be used as base template to easily start writing your app with the support of a basic CI pipeline that includes testing, linting and code coverage.

Pipeline can be run in you development environment or directly in GitHub.

## Workflows status

![CI](https://github.com/romitagl/python_ci_template/workflows/Make%20CI%20Workflow/badge.svg)

## Features

Is currently supported:

- Formatting using [black](https://black.readthedocs.io/en/stable/)
- [Isort](https://pypi.org/project/isort/) sorts your imports.
- Linting checks using [flake8](http://flake8.pycqa.org/en/latest/)
- Testing using [pytest](https://pypi.org/project/pytest/)
- Executing the target app in a container using [Docker](https://www.docker.com)
- [GitHub Actions](https://github.com/features/actions) integration for CI/CD executions
- Project can be used as GitHub Template

## How To Run

### Dependencies

- [Docker](https://www.docker.com)
- [GNU Make](https://www.gnu.org/software/make/)

### Quick spin

Run `run_docker_image` in the command line. This command will build the CI image running all tests and finally build the release target image and run it.

Makefile contains all the targets to run the code in a containerized environment (Docker) and natively.

#### Local Development/Testing

The `run_docker_bash` make target can be used for development/testing without having to install the Python dependencies in the host machine. Everything can be run in a `python:3.10-buster` Docker image.

The following commands show how to run the image and format the python code:

```bash
make run_docker_bash
cd /app
make dev_dependencies
make activate_pipenv
make format
```

### Structure

- `src` contains the source code of the target app. Use `app.py` as *main()* file.
- `tests` include the *pytest* files used to test the app
- `Makefile` implements all the *Features* currently supported
- `Dockerfile` Docker image used for releasing the target app

## Notes

### Run Docker as a non-root user

Create the docker group and add your user to the docker group:

```bash
sudo groupadd docker
sudo usermod -aG docker $USER
```
