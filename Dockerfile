# syntax=docker/dockerfile:1

# https://docs.docker.com/go/dockerfile-reference/

# Dockerfile co-generated with `docker init`

# -- BASE IMAGE --
ARG PYTHON_VERSION
FROM python:${PYTHON_VERSION} as base

# Setup env
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
# Prevents Python from writing pyc files.
ENV PYTHONDONTWRITEBYTECODE=1
# Keeps Python from buffering stdout and stderr to avoid situations where
# the application crashes without emitting any logs due to buffering.
ENV PYTHONUNBUFFERED=1
ENV PYTHONFAULTHANDLER=1

WORKDIR /app

# Create a non-privileged user that the app will run under.
# See https://docs.docker.com/go/dockerfile-user-best-practices/
ARG UID=10001
RUN adduser \
    --disabled-password \
    --gecos "" \
    --home "/nonexistent" \
    --shell "/sbin/nologin" \
    --no-create-home \
    --uid "${UID}" \
    appuser

# Download dependencies as a separate step to take advantage of Docker's caching.
# Leverage a cache mount to /root/.cache/pip to speed up subsequent builds.
# Leverage a bind mount to Pipfile to avoid having to copy them into
# into this layer.
# --deploy — Make sure the packages are properly locked in Pipfile.lock, and abort if the lock file is out-of-date.
RUN --mount=type=cache,target=/root/.cache/pip \
    --mount=type=bind,source=Pipfile,target=Pipfile \
    --mount=type=bind,source=Pipfile.lock,target=Pipfile.lock \
    pip install pipenv && PIPENV_VENV_IN_PROJECT=1 pipenv install --deploy

ENV PATH="/.venv/bin:$PATH"

# Pipenv Upgrade Workflow
# Find out what’s changed upstream: $ pipenv update --outdated.
# Want to upgrade everything? Just do $ pipenv update.

# -- CI IMAGE --
FROM base as ci

# add ci files
COPY . .

# install Python Dev dependencies
RUN PIPENV_VENV_IN_PROJECT=1 pipenv install --dev
# activate the virtual environment
ENV PATH="/app/.venv/bin:$PATH"
# run tests
RUN make ci

# -- RELEASE IMAGE --
FROM base as release

# add production source code
COPY ./src .

# Run the application.
CMD python app.py