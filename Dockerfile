# -- BASE IMAGE --
ARG python_version
FROM python:${python_version} as base

# Setup env
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONFAULTHANDLER 1

WORKDIR /

# Install pipenv and compilation dependencies
RUN pip install pipenv

# Install python dependencies in /.venv
COPY Pipfile .
COPY Pipfile.lock .
# --deploy — Make sure the packages are properly locked in Pipfile.lock, and abort if the lock file is out-of-date.
RUN PIPENV_VENV_IN_PROJECT=1 pipenv install --deploy
ENV PATH="/.venv/bin:$PATH"

# Pipenv Upgrade Workflow
# Find out what’s changed upstream: $ pipenv update --outdated.
# Want to upgrade everything? Just do $ pipenv update.

# -- CI IMAGE --
FROM base as ci

WORKDIR /ci

# add ci files
COPY . .

# install Python Dev dependencies
RUN PIPENV_VENV_IN_PROJECT=1 pipenv install --dev
# activate the virtual environment
ENV PATH="/ci/.venv/bin:$PATH"
# run tests
RUN make ci

# -- RELEASE IMAGE --
FROM base as release

WORKDIR /app

# add production source code
COPY ./src .

ENTRYPOINT ["python", "app.py"]