FROM ubuntu:20.04

RUN apt-get update && apt-get install -y \
	wget \
	git \
	bash \
	make \
	sudo \
	unzip

# Install go
RUN wget https://dl.google.com/go/go1.14.4.linux-amd64.tar.gz \
	&& tar -xvf go1.14.4.linux-amd64.tar.gz \
	&& mv go /usr/local
ENV GOROOT /usr/local/go
ENV PATH $GOROOT/bin:$PATH
ENV GOPATH /root/go
ENV PATH $GOPATH/bin:$GOROOT/bin:$PATH
ENV APIPATH /root/go/src/api

# Copy in the local repository to build from.
RUN git clone https://github.com/lightningnetwork/lnd.git --branch v0.10.1-beta

# gomobile
RUN go get golang.org/x/mobile/cmd/gomobile

# falafel
RUN go get -u -v github.com/lightninglabs/falafel

# goimports
RUN go get -u -v golang.org/x/tools/cmd/goimports

# protoc
RUN go get -u github.com/lightningnetwork/lnd/lnrpc \
	&& cd lnd \
	&& ./scripts/install_travis_proto.sh

ENV ANDROID_NDK_HOME /ndk
ENV ANDROID_HOME /android

# Install OpenJDK-8
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
	apt-get install -y openjdk-8-jdk && \
	apt-get install -y ant && \
	apt-get clean;

CMD ["sh", "-c", "gomobile init; cd lnd && make android"]
