FROM elasticsearch

RUN apt-get update -qq && \
    apt-get install -qqy python jq && \
    apt-get clean -qq && \
    curl -L "https://bootstrap.pypa.io/get-pip.py" | python - && \
    curl -L "https://github.com/sstephenson/bats/archive/v0.4.0.tar.gz" | tar xz -C "/tmp" && \
    bash /tmp/bats-0.4.0/install.sh /usr/local && \
    rm -rf /tmp/bats-0.4.0
