# Builder image
FROM python:3.11-buster as builder

RUN pip install poetry==1.4.2

ENV DEBIAN_FRONTEND=noninteractive

ARG SFCLI_URL=https://developer.salesforce.com/media/salesforce-cli/sf/channels/stable/sf-linux-x64.tar.xz

RUN apt-get update

WORKDIR /cli

RUN wget ${SFCLI_URL} \
    && tar xJf sf-linux-x64.tar.xz -C /cli --strip-components 1 \
    && rm -rf sf-linux-x64.tar.xz

# RUN apt-get install --assume-yes \
#     openjdk-11-jdk-headless

# RUN apt-get autoremove --assume-yes \
#     && apt-get clean --assume-yes \
#     && rm -rf /var/lib/apt/lists/*


ENV POETRY_NO_INTERACTION=1 \
    POETRY_VIRTUALENVS_IN_PROJECT=1 \
    POETRY_VIRTUALENVS_CREATE=1 \
    POETRY_CACHE_DIR=/tmp/poetry_cache

ENV PATH="/sf/bin:$PATH"
ENV SFDX_CONTAINER_MODE true
ENV SHELL /bin/bash

WORKDIR /app

COPY pyproject.toml poetry.lock ./app/
RUN --mount=type=cache,target=$POETRY_CACHE_DIR poetry install --without dev --no-root

# Runtime image
FROM python:3.11-slim-buster as runtime

ENV VIRTUAL_ENV=/app/.venv \
    PATH="/app/.venv/bin:$PATH"

COPY --from=builder ${VIRTUAL_ENV} ${VIRTUAL_ENV}
COPY app.py ./app/app.py
COPY sfmanager ./app/sfmanager

ENTRYPOINT [ "python", "app/app.py" ]
