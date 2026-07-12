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

COPY scripts/*.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/*.sh

ARG target
RUN /usr/local/bin/setup-environment.sh "$target"

ENTRYPOINT [ "kiro-cli" ]

FROM oven/bun:debian AS opencode
RUN bun add -g opencode-ai

COPY scripts/*.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/*.sh

ARG target
RUN apt update && /usr/local/bin/setup-environment.sh "$target"

ENTRYPOINT [ "opencode" ]
