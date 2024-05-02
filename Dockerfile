FROM golang:1.22 AS build-stage

LABEL org.opencontainers.image.base.digest="sha256:5370d4968adad7e969494e744c6d28a93931b89f259accf4d08a94c30446d3a3"
LABEL org.opencontainers.image.base.name="golang"

# syntax=docker/dockerfile:1

# Set destination for COPY
WORKDIR /app

# Download Go modules
COPY go.mod go.sum ./
RUN go mod download

# Copy the source code. Note the slash at the end, as explained in
# https://docs.docker.com/reference/dockerfile/#copy
COPY *.go ./

# Build
RUN CGO_ENABLED=0 GOOS=linux go build -o /docker-gs-ping

# Optional:
# To bind to a TCP port, runtime parameters must be supplied to the docker command.
# But we can document in the Dockerfile what ports
# the application is going to listen on by default.
# https://docs.docker.com/reference/dockerfile/#expose
EXPOSE 8080

# Run
CMD ["/docker-gs-ping"]
