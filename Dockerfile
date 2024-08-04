FROM ubuntu:noble
LABEL maintainer="Tomáš Havlas"

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       sudo systemd systemd-sysv \
       build-essential wget libffi-dev libssl-dev locales procps iproute2 \
       python3-pip python3-dev python3-setuptools python3-wheel python3-apt \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /usr/share/doc /usr/share/man \
    && rm -f /lib/systemd/system/multi-user.target.wants/getty.target \
    && apt-get clean

RUN locale-gen en_US.UTF-8 \
    && rm -f /usr/lib/python3.12/EXTERNALLY-MANAGED \
    && pip3 install --upgrade pip \
    && pip3 install ansible cryptography

RUN mkdir -p /etc/ansible \
    && echo "[local]\nlocalhost ansible_connection=local" > /etc/ansible/hosts

VOLUME ["/sys/fs/cgroup"]
CMD ["/lib/systemd/systemd"]
