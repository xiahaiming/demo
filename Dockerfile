FROM golang:1.10-alpine3.8 AS builder

ENV CGO_ENABLED=0
ENV GOOS=linux
ENV GOARCH=amd64

# This can speed up future builds because of cache, only rebuild when vendors are
# added.
ADD . /go/src/demo
WORKDIR /go/src/demo

RUN go build -ldflags="-X mimir/corelib/basic.BuildTime=`date +%FT%T%z`" -o /go/bin/main main.go

# Restart and only copy the built binary
FROM alpine:3.8
COPY --from=builder /go/bin/main /go/bin/main
COPY --from=builder /usr/local/go/lib/time/zoneinfo.zip /usr/local/go/lib/time/zoneinfo.zip
ENTRYPOINT ["/go/bin/main"]

