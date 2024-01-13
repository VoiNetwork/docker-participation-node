# Voi Network Participation Node Docker image

This repository contains a Dockerfile for building a Voi Network participation node Docker image.
The image contains no key material, and is intended to be used with a participation key injected at runtime.

## Running the image

```bash
docker run ghcr.io/voinetwork/docker-participation-node:latest
```

By default the image will listen on port 8080 for incoming connections. To run the image with the REST API exposed on
local port 8080 execute:
```bash
docker run -p 8080:8080 ghcr.io/voinetwork/docker-participation-node:latest
```

## Image updates and support
Images will be published via GitHub Actions packaged releases and will be available at the following location:

```bash
docker pull ghcr.io/voinetwork/docker-participation-node:latest
```

Versioned images will be available by replacing `latest` with the desired version number.
```bash:
docker pull ghcr.io/voinetwork/docker-participation-node:3.20.1
```

Images tags are not immutable and will be overwritten when a new image is published with the same tag.
`latest` tag will continuously be updated to point to the latest version, as will the most recent release tag.

Example:
Version 3.18.0, 3.20.1 and 3.21.0 is published in that order. The following tags will continuously see updates with security patches
- `latest` will point to 3.21.0 image with latest updates
- `3.21.0` will point to 3.21.0 image with latest updates

The following tags will not be updated in the above scenario, and will be considered deprecated:
- `3.20.1`
- `3.18.0`

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

## Creating a release
To create a release and publish the image to the container registry, create a new release in GitHub and tag it with the
version number of the Algorand image to use as base image. The GitHub Action will then build and publish the image to
registry.

## Notes

* Mount points inside the image are using the default Algorand mount points, which can be overridden for persistent claims.
* The image versioning is aligned with the official Algorand release versions.
* Catchup via the environment variable VOI_FAST_CATCHUP is set to true by default.
  * This variable mimics the behavior from the Algorand image, but will result in faster catchup (as more aggressive). 