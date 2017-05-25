FROM alpine

RUN apk --update add ca-certificates

RUN mkdir -p /app/pwd

COPY ./www /app/www

ADD docker-labs_linux_amd64 /app/docker-labs

WORKDIR /app

EXPOSE 3000

ENTRYPOINT ["./docker-labs"]

CMD ["-name", "docker-labs"]

