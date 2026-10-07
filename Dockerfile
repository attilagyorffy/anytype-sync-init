# The config generator of anyproto/any-sync-dockercompose v8.0.1
# (Dockerfile-any-sync-init), with its base image and yq pinned and its
# scripts built in. It runs once, to make a network's keys and configs; the
# running network does not use it.

FROM ghcr.io/anyproto/any-sync-tools:v0.7.0@sha256:ee6cf65958ee4e9b558c3973802b7fbd64b3a66c7cf78d64d1a08fb9de0af510

ARG TARGETARCH
ARG YQ_VERSION=v4.54.1

RUN set -eux; \
    apt update; \
    apt install -y --no-install-recommends \
        bash \
        curl \
        ca-certificates \
        perl \
        python3 \
        python3-yaml \
        python-is-python3; \
    curl -fsSL "https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_linux_${TARGETARCH}" \
        -o /usr/local/bin/yq; \
    chmod +x /usr/local/bin/yq; \
    yq --version; \
    rm -rf /var/lib/apt/lists/*

WORKDIR /code
COPY docker-generateconfig /code/docker-generateconfig
ENTRYPOINT ["bash", "/code/docker-generateconfig/init.sh"]
