FROM alpine:latest

RUN apk update && \
    apk add --no-cache yt-dlp bash

WORKDIR /app

COPY download.sh /app/

RUN chmod +x /app/download.sh

ENTRYPOINT ["/app/download.sh"]
