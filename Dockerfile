FROM golang:alpine as builder
RUN apk --no-cache add git
RUN git clone https://github.com/FiloSottile/mkcert && cd mkcert && git checkout v1.4.3 && go build -ldflags "-X main.Version=$(git describe --tags)"

FROM alpine:3
ENV CAROOT=/mkcert
WORKDIR /mkcert
COPY --from=builder /go/mkcert/mkcert /usr/bin/mkcert
ENTRYPOINT [ "/usr/bin/mkcert" ]
