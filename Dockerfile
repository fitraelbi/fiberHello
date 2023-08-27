FROM golang:alpine as build-env

ARG SERVICE_NAME=hello

RUN mkdir /app
ADD . /app/

WORKDIR /app
RUN apk add --no-cache git
RUN go build  -o ${SERVICE_NAME} .

FROM alpine
WORKDIR /app
COPY --from=build-env /app/${SERVICE_NAME}    /app/${SERVICE_NAME}

EXPOSE 3000

ENTRYPOINT ["/app/hello"]
