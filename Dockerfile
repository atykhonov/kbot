FROM quay.io/projectquay/golang:1.20 AS builder

WORKDIR /go/src/app
COPY . .
RUN go get
RUN make build

FROM scratch
WORKDIR /
COPY --from=builder /go/src/app/kbot .
COPY --from=builder /go/src/app/.env .
COPY --from=alpine:latest /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

ENTRYPOINT [ "./kbot", "start" ]