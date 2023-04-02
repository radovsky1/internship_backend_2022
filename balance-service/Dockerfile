FROM golang:1.19-buster as builder

RUN apt-get update \
    && apt-get install -y --no-install-recommends git && \
    go install -tags 'postgres' github.com/golang-migrate/migrate/v4/cmd/migrate@latest

ENV GO111MODULE "on"

WORKDIR /app

COPY go.mod .
COPY go.sum .

RUN go mod download

COPY . .

RUN GOOS=linux GOARCH=amd64 go build -tags=jsoniter -o main ./cmd/main

FROM debian:buster-slim

WORKDIR /app

COPY --from=builder /app/main /app/
COPY --from=builder /go/bin/migrate /usr/bin/migrate
COPY --from=builder /app/scripts/migrate.sh /usr/bin/migrate-script
COPY --from=builder /app/migrations /app/migrations
RUN chmod +x /usr/bin/migrate-script

ENTRYPOINT ["/app/main"]