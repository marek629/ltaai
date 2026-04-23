FROM nickblah/lua:5.3-noble

WORKDIR /home/ubuntu
ENV EDITOR=nano

RUN apt update && apt install wget nano -y \
    && echo "Downloading kiro-cli package..." \
    && wget -q https://desktop-release.q.us-east-1.amazonaws.com/latest/kiro-cli.deb \
    && echo "Done!"
RUN dpkg -i kiro-cli.deb || apt-get install -fy \
    && rm kiro-cli.deb \
    && rm -rf /var/lib/apt/lists/*

ENTRYPOINT [ "kiro-cli" ]
