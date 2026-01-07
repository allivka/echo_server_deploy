FROM alpine:latest AS builder

RUN apk add --no-cache build-base

WORKDIR /build
COPY server.c .
RUN gcc server.c -o server

FROM alpine:latest AS runner

WORKDIR /app
COPY --from=builder /build/server /app/server

EXPOSE 8081
ENTRYPOINT ["./server", "8081"]
