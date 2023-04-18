# Pushpin Dockerfile


This repository contains **Dockerfile** of [Pushpin](http://pushpin.org/) for [Docker](https://www.docker.com/) published to the public [Docker Hub Registry](https://hub.docker.com/).

**This is an unofficial Docker image**, changes from the official one include:
- Image is based on Debian Stable (slim version), not on Ubuntu 22.04
- There is also an ARM64 version of the image, not only AMD64 (*the reason I made this image in the first place*)
- Pushpin is installed from Debian's `testing` repository, not from the Pushpin developers' repository (fanout.jfrog.io)
- The version of Pushpin to be installed is determined by the current version in Debian's `testing` repository ([check the current version of the package here](https://packages.debian.org/testing/pushpin))
- To pull the image, obviously, you use `m4l3vich/pushpin` tag, and not `fanout/pushpin`

Everything else is basically the same.

## Base Docker Image

* [debian:stable-slim](https://hub.docker.com/_/debian/)

## Installation

1. Install [Docker](https://www.docker.com/).

2. Download [automated build](https://hub.docker.com/r/m4l3vich/pushpin/) from public [Docker Hub Registry](https://hub.docker.com/): `docker pull m4l3vich/pushpin`

Alternatively, you can build an image from the `Dockerfile`:

```sh
docker build -t m4l3vich/pushpin .
```

## Usage

```sh
docker run \
  -d \
  -p 7999:7999 \
  -p 5560-5563:5560-5563 \
  --rm \
  --name pushpin \
  m4l3vich/pushpin
```

By default, Pushpin routes traffic to a test handler.  See the [Getting Started Guide](https://pushpin.org/docs/getting-started/) for more information.

Open `http://<host>:7999` to see the result.

#### Configure Pushpin to route traffic

To add custom Pushpin configuration to your Docker container, attach a configuration volume.

```sh
docker run \
  -d \
  -p 7999:7999 \
  -p 5560-5563:5560-5563 \
  -v $(pwd)/config:/etc/pushpin/ \
  --rm \
  --name pushpin \
  fanout/pushpin
```

Note: The Docker entrypoint may make modifications to `pushpin.conf` so it runs properly in its container, exposing ports `7999`, `5560`, `5561`, `5562`, and `5563`.

See project documentation for more on [configuring Pushpin](https://pushpin.org/docs/configuration/).
