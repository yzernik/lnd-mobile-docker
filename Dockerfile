FROM golang:1.12-alpine as builder

RUN apk update && \
	apk upgrade && \
	apk add --no-cache \
	git \
	bash \
	make \
	sudo

# Copy in the local repository to build from.
RUN git clone https://github.com/lightningnetwork/lnd.git --branch v0.10.1-beta

# protoc
RUN go get -u github.com/lightningnetwork/lnd/lnrpc \
	&& cd lnd \
	&& ./scripts/install_travis_proto.sh

# gomobile
RUN go get golang.org/x/mobile/cmd/gomobile \
	&& gomobile init

# falafel
RUN go get -u -v github.com/lightninglabs/falafel

# goimports
RUN go get -u -v golang.org/x/tools/cmd/goimports

# android
RUN cd lnd \
	&& make android

# Copy the entrypoint script.
# COPY "docker/lnd/start-lnd.sh" .
RUN echo "Finished script"
