# Description

This project can be used as base template to easily start writing your app with the support of a basic CI pipeline that includes testing, linting and code coverage.

Pipeline can be run in you development environment or directly in GitHub.

## Workflows status
![](https://github.com/romitagl/python_ci_template/workflows/Make%20CI%20Workflow/badge.svg)

# Features

Is currently supported:
- Linting checks using [flake8](http://flake8.pycqa.org/en/latest/)
- Testing using [pytest](https://pypi.org/project/pytest/)
- Executing the target app in a container using [Docker](https://www.docker.com) 
- [GitHub Actions](https://github.com/features/actions) integration for CI/CD executions 
- Project can be used as GitHub Template

# How To Run

## Dependencies
- [Docker](https://www.docker.com) 
- [GNU Make](https://www.gnu.org/software/make/)

## Quick spin

Install the *dependencies* and run `make` in the command line.

Makefile contains all the targets to run the code in a containerized environment (Docker).

# Structure

- `src` contains the source code of the target app. Use `app.py` as *main()* file.
- `tests` include the *pytest* files used to test the app
- `test-results` contains test and coverage results
- `Makefile` implements all the *Features* currently supported
- `Dockerfile` Docker image used for releasing the target app. Installs `requirements.txt`
- `Dockerfile_dec` Docker image that contains the development dependencies, based on the *release* image. Installs `requirements_dev.txt`


# Notes

### Run Docker as a non-root user
Create the docker group and add your user to the docker group:
```bash
sudo groupadd docker
sudo usermod -aG docker $USER
```
