# Voi Network Participation Node Docker image

This repository contains a Dockerfile for building a Voi Network participation node Docker image.
The image contains no key material, and is intended to be used with a participation key injected at runtime.

## Building the image

The image can be built using the following command:

```bash
docker build .
```

To provide an Algorand version to use as base image, use the `BASE_ALGORAND_VERSION` build argument:
```bash
docker build --build-arg="BASE_ALGORAND_VERSION=3.20.1" .
```

The `BASE_ALGORAND_VERSION` argument is used to specify the version of the Algorand image to use as base image.
Defaults to `3.20.1`.

## Running the image

```bash
docker run <image_tag>
```

By default the image will listen on port 8080 for incoming connections. To run the image with the REST API exposed on 
local port 8080 execute:
```bash
docker run -p 8080:8080 <image_tag>
```

## Container registry
Images will be published via GitHub Actions packaged releases and will be available at the following location:  

```bash
docker pull ghcr.io/voinetwork/docker-participation-node:latest
```

Versioned images will be available by replacing `latest` with the desired version number.
```bash:
docker pull ghcr.io/voinetwork/docker-participation-node:3.20.1
```

## Creating a release
To create a release and publish the image to the container registry, create a new release in GitHub and tag it with the
version number of the Algorand image to use as base image. The GitHub Action will then build and publish the image to
registry.

## Notes

* Mount points inside the image are using the default Algorand mount points, which can be overridden for persistent claims.
* The image versioning is aligned with the official Algorand release versions.
* Catchup via the environment variable VOI_FAST_CATCHUP is set to true by default.
  * This variable mimics the behavior from the Algorand image, but will result in faster catchup (as more aggressive). 