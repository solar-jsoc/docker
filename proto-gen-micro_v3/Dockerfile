FROM golang:1.18 as builder
WORKDIR /tmp/proto
ENV GOPATH=/tmp/proto

RUN apt-get update
RUN apt-get install -y unzip

# protoc
RUN curl https://github.com/protocolbuffers/protobuf/releases/download/v3.19.4/protoc-3.19.4-linux-x86_64.zip -L -o protoc.zip
RUN unzip protoc.zip

# protoc-gen-go
RUN go install github.com/gogo/protobuf/protoc-gen-gogo@v1.3.2

# protoc-gen-micro
RUN go install github.com/asim/go-micro/cmd/protoc-gen-micro/v3@v3.7.0

FROM busybox:1.31-glibc
COPY --from=builder /tmp/proto/bin/protoc /usr/local/bin/protoc
COPY --from=builder /tmp/proto/include/google /usr/local/include/google
COPY --from=builder /tmp/proto/bin/protoc-gen-gogo /usr/local/bin/protoc-gen-gogo
COPY --from=builder /tmp/proto/bin/protoc-gen-micro /usr/local/bin/protoc-gen-micro
