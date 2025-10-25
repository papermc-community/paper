ARG RUNTIME_IMAGE=docker.io/eclipse-temurin:8-jre-alpine-3.22

FROM alpine:3.22 AS base
WORKDIR /app

ARG PAPER_DOWNLOAD_URL
RUN set -eux; \
    apk add --no-cache curl; \
    curl -LfS "${PAPER_DOWNLOAD_URL}" -o "paper.jar";

FROM ${RUNTIME_IMAGE} AS runtime
WORKDIR /app

RUN addgroup -S paper && adduser -S paper -G paper

COPY --from=base --chown=paper:paper /app/paper.jar /app/paper.jar

RUN chown -R paper:paper /app
USER paper

RUN echo "eula=true" > eula.txt

ENV JAVA_TOOL_OPTIONS="-Xms512m -Xmx1024m -Dfile.encoding=UTF-8" \
    INTERNAL_PORT=25565

EXPOSE ${INTERNAL_PORT}

HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
    CMD nc -z 127.0.0.1 ${INTERNAL_PORT} || exit 1

ENTRYPOINT [ "java", "-jar", "/app/paper.jar" ]