FROM golang:1.22 AS build-stage

LABEL org.opencontainers.image.base.digest="sha256:cac8fb1c85bf96316112f5dd2671c8da0c19d2dfce88af9551b3141499a59eaf"
LABEL org.opencontainers.image.base.name="golang"

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY *.go ./

RUN CGO_ENABLED=0 GOOS=linux go build -o /go-ping

EXPOSE 8080

USER nonroot:nonroot

ENTRYPOINT ["/go-ping"]
