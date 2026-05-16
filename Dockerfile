FROM ubuntu:26.04 AS kiro
WORKDIR /home/ubuntu
ENV EDITOR=nano
RUN apt update && apt install wget nano git ca-certificates -y --no-install-recommends \
    && update-ca-certificates
RUN echo "Downloading kiro-cli package..." \
    && wget -q https://desktop-release.q.us-east-1.amazonaws.com/latest/kiro-cli.deb \
    && echo "Done!" \
    && (dpkg -i kiro-cli.deb || apt-get install -fy --no-install-recommends) \
    && rm kiro-cli.deb

ARG target
RUN set -eux; \
    echo "Setting up ${target} environment..."; \
    case "$target" in \
        lua) \
            apt-get install -y --no-install-recommends lua5.5 luarocks; \
            ;; \
        yarn) \
            apt-get install -y --no-install-recommends nodejs node-corepack \
            && corepack enable; \
            ;; \
        pytest) \
            apt-get install -y --no-install-recommends \
                python3 python3-pip python3-pytest; \
            ;; \
        *) \
            echo "ERROR: Unknown target: '$target'"; \
            exit 1; \
            ;; \
    esac; \
    rm -rf /var/lib/apt/lists/*

ENTRYPOINT [ "kiro-cli" ]
