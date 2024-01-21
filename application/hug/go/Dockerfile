FROM golang:1.21 AS build-stage

WORKDIR /app
COPY . .
RUN cd ./src/ && go mod download
RUN cd ./src/ && CGO_ENABLED=0 GOOS=linux go build -o ../bin/hug


FROM gcr.io/distroless/static-debian12:nonroot

COPY --from=build-stage /app/bin/hug /app/bin/

EXPOSE 8000
CMD ["/app/bin/hug"]