FROM golang:1.20.4-bullseye

WORKDIR /app 
COPY go.mod ./
RUN go mod download
COPY *.go ./
RUN CGO_ENABLED=0 GOOS=linux go build -o /go-test-server
CMD ["/go-test-server"]
