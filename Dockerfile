FROM node:24
RUN apt-get update && apt-get install -y curl

RUN adduser --disabled-password clusterio
RUN mkdir /clusterio && chown clusterio:clusterio /clusterio && mkdir /factorio && chown clusterio:clusterio /factorio
# RUN ln -s /lib /lib64
USER clusterio

WORKDIR /clusterio

COPY docker-entrypoint.sh /docker-entrypoint.sh

ENV CLUSTERIO_MODE=standalone
ENV CLUSTERIO_ADMIN=
ENV CLUSTERIO_PLUGINS="@clusterio/plugin-global_chat @clusterio/plugin-inventory_sync @clusterio/plugin-player_auth @clusterio/plugin-research_sync @clusterio/plugin-statistics_exporter @clusterio/plugin-subspace_storage @hornwitser/discord_bridge @hornwitser/server_select"

ENV CLUSTERIO_HOST_CONTROLLER_TOKEN=
ENV CLUSTERIO_HOST_CONTROLLER_URL=http://localhost:8080/
ENV CLUSTERIO_HOST_NAME=Host


CMD [ "/bin/sh", "/docker-entrypoint.sh" ]
# CMD [ "/bin/sh", "-c", "while true; do sleep 1; done" ]
