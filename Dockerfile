# build stage
FROM golang:alpine AS builder
RUN apk add --no-cache git gcc libc-dev
WORKDIR /go/src/app
COPY . .
RUN go build -mod vendor -o /go/bin/app .

# final stage
FROM alpine:latest
LABEL Name=test-actions Version=0.0.1
RUN apk --no-cache add ca-certificates
COPY --from=builder /go/bin/app /app
ENTRYPOINT ["./app"]

