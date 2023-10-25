# FROM salesforce/cli:latest-slim as cli

FROM python:3.11-buster as builder

# COPY --from=cli /usr/local/sf/bin/ /usr/local/sf/bin/

ARG SFCLI_URL=https://developer.salesforce.com/media/salesforce-cli/sf/channels/stable/sf-linux-x64.tar.xz

# Install Salesforce CLI
RUN apt-get update && apt-get install -y wget && \
    wget ${SFCLI_URL} -O sf.tar.xz && \
    mkdir -p /usr/local/cli/sf && \
    tar xJf sf.tar.xz -C /usr/local/cli/sf --strip-components 1

RUN pip install poetry==1.4.2

ENV POETRY_NO_INTERACTION=1 \
    POETRY_VIRTUALENVS_IN_PROJECT=1 \
    POETRY_VIRTUALENVS_CREATE=1 \
    POETRY_CACHE_DIR=/tmp/poetry_cache

WORKDIR /app

COPY pyproject.toml poetry.lock ./
RUN --mount=type=cache,target=$POETRY_CACHE_DIR poetry install --without dev --no-root

# FROM python:3.11-slim-buster as runtime

# COPY --from=builder /usr/local/sf/bin/ /usr/local/sf/bin/

ENV VIRTUAL_ENV=/app/.venv \
    PATH="/app/.venv/bin:/usr/local/cli/sf/bin:$PATH"

# COPY --from=builder ${VIRTUAL_ENV} ${VIRTUAL_ENV}
COPY app.py ./app.py
COPY sfmanager ./sfmanager

ENTRYPOINT [ "python", "app.py" ]
