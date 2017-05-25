FROM hub.c.163.com/library/golang:1.8.2

# Copy the runtime dockerfile into the context as Dockerfile
COPY Dockerfile.run /go/bin/Dockerfile
COPY ./www /go/bin/www

COPY . /go/src/github.com/bingohuang/docker-labs

WORKDIR /go/src/github.com/bingohuang/docker-labs

RUN go get -v -d ./...

RUN CGO_ENABLED=0 go build -a -installsuffix nocgo -o /go/bin/docker-labs .

# Set the workdir to be /go/bin which is where the binaries are built
WORKDIR /go/bin

# Export the WORKDIR as a tar stream
CMD tar -cf - .
