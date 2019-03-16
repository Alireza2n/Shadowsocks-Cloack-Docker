FROM shadowsocks/shadowsocks-libev
LABEL maintainer="Alireza <alireza@amouzadeh.net>"

# Install go git make as root
USER root
RUN apk add --no-cache git make go

# Configure Go
ENV GOROOT /usr/lib/go
ENV GOPATH /go
ENV PATH /go/bin:$PATH
RUN mkdir -p ${GOPATH}/src ${GOPATH}/bin

# Requirements for Cloak
RUN go get github.com/boltdb/bolt && go get github.com/juju/ratelimit && go get golang.org/x/crypto/curve25519
RUN mkdir -p ${GOPATH}/github.com/cbeuw
WORKDIR ${GOPATH}/github.com/cbeuw
RUN git clone https://github.com/cbeuw/Cloak.git
RUN make server && make client