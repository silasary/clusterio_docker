FROM node:20-alpine
RUN apk add --no-cache curl

RUN adduser -D clusterio
RUN mkdir /clusterio && chown clusterio:clusterio /clusterio && mkdir /factorio && chown clusterio:clusterio /factorio
USER clusterio

WORKDIR /clusterio

COPY docker-entrypoint.sh /docker-entrypoint.sh

ENV CLUSTERIO_MODE=standalone
ENV CLUSTERIO_ADMIN=
ENV CLUSTERIO_PLUGINS="@clusterio/plugin-global_chat @clusterio/plugin-inventory_sync @clusterio/plugin-player_auth @clusterio/plugin-research_sync @clusterio/plugin-statistics_exporter @clusterio/plugin-subspace_storage @hornwitser/discord_bridge @hornwitser/server_select"

CMD [ "/bin/sh", "/docker-entrypoint.sh" ]
# CMD [ "/bin/sh", "-c", "while true; do sleep 1; done" ]
