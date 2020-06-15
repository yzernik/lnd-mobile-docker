FROM golang:1.12-alpine as builder

MAINTAINER Olaoluwa Osuntokun <lightning.engineering>

RUN apk update && \
    apk upgrade && \
    apk add git

# Copy in the local repository to build from.
RUN git clone https://github.com/lightningnetwork/lnd.git --branch v0.10.1-beta

# protoc
RUN go get -u github.com/lightningnetwork/lnd/lnrpc

# Add bash.
RUN apk add --no-cache \
	bash \
	make

RUN set -ex && apk --no-cache add sudo

# Install dependencies and install/build lnd.
RUN cd lnd \
	&& ./scripts/install_travis_proto.sh

# Copy the entrypoint script.
# COPY "docker/lnd/start-lnd.sh" .
RUN echo "Finished script"
