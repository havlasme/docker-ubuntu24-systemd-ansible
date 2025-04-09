FROM ubuntu:noble
LABEL maintainer="Tomáš Havlas"

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       sudo dbus systemd systemd-sysv \
       build-essential wget libffi-dev libssl-dev libyaml-dev locales procps iproute2 util-linux-extra \
       python3-pip python3-dev python3-setuptools python3-wheel python3-yaml python3-apt \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /usr/share/doc /usr/share/man \
    # Remove unnecessary getty and udev services that can cause high CPU usage
    # when using multiple containers with Molecule (https://github.com/ansible/molecule/issues/1104)
    && rm -f /lib/systemd/system/systemd*udev* \
    && rm -f /lib/systemd/system/getty.target


RUN locale-gen en_US.UTF-8 \
    && rm -f /usr/lib/python3.12/EXTERNALLY-MANAGED \
    && pip3 install ansible cryptography

RUN mkdir -p /etc/ansible \
    && echo "[local]\nlocalhost ansible_connection=local" > /etc/ansible/hosts

VOLUME ["/sys/fs/cgroup", "/tmp", "/run"]
CMD ["/lib/systemd/systemd"]
