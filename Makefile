VERSION ?= latest
NAMESPACE ?= havlasme
IMAGENAME ?= ubuntu24-systemd-ansible

PODMAN = @podman

.PHONY: build
build:
	$(PODMAN) build -t $(NAMESPACE)/$(IMAGENAME):$(VERSION) .
