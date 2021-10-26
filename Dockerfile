# docker build -t go-file-server:1 .
# docker push go-file-server:1
# docker run -d --restart=unless-stopped --memory 1G --memory-swap 1G -v ios-qa-distribs:/distribs -p 8888:8888 --name=goFileServer go-file-server:1

FROM golang:1.17.2

WORKDIR /build

RUN mkdir /distribs

COPY go.mod .
COPY go.sum .
RUN go mod download

COPY goFileServer.go .

RUN go build -v -o goFileServer goFileServer.go

WORKDIR /app

RUN cp /build/goFileServer .

EXPOSE 8888

CMD ["/app/goFileServer", "8888", "/distribs"]
