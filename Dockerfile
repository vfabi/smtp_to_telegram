FROM golang:1.21-alpine AS builder

RUN mkdir /smtptg
WORKDIR /smtptg

COPY go.mod go.mod
COPY go.sum go.sum
COPY smtptg.go smtptg.go

RUN go build -o smtptg ./smtptg.go

FROM alpine:latest

RUN apk add --no-cache ca-certificates mailcap

COPY --from=builder /smtptg/smtptg /usr/bin/
ENV ST_SMTP_LISTEN="0.0.0.0:2525"
EXPOSE 2525
USER nobody
CMD ["/usr/bin/smtptg"]
