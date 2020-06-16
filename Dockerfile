FROM ubuntu:20.04

RUN apt-get update && apt-get install -y \
	wget \
	git \
	bash \
	make \
	sudo \
	unzip

# Install go
RUN wget https://dl.google.com/go/go1.12.17.linux-amd64.tar.gz \
	&& tar -xvf go1.12.17.linux-amd64.tar.gz \
	&& mv go /usr/local
ENV GOROOT /usr/local/go
ENV PATH $GOROOT/bin:$PATH
ENV GOPATH /root/go
ENV PATH $GOPATH/bin:$GOROOT/bin:$PATH
ENV APIPATH /root/go/src/api

# Copy in the local repository to build from.
RUN git clone https://github.com/lightningnetwork/lnd.git --branch v0.10.1-beta

# protoc
RUN go get -u github.com/lightningnetwork/lnd/lnrpc \
	&& cd lnd \
	&& ./scripts/install_travis_proto.sh

# gomobile
RUN go get golang.org/x/mobile/cmd/gomobile

# falafel
RUN go get -u -v github.com/lightninglabs/falafel

# goimports
RUN go get -u -v golang.org/x/tools/cmd/goimports

WORKDIR lnd

# Add the ndk directory
COPY ndk/ ndk/
ENV ANDROID_NDK_HOME ndk
RUN ls -l .
RUN ls -l $ANDROID_NDK_HOME

CMD ["sh", "-c", "ANDROID_NDK_HOME=ndk gomobile init; make android"]
