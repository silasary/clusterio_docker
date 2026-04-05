if [ ! -d /factorio/factorio ] && ([ "$CLUSTERIO_MODE" = "host" ] || [ "$CLUSTERIO_MODE" = "standalone" ]); then
    wget -q -O factorio.tar.gz https://www.factorio.com/get-download/latest/headless/linux64 && tar -xf factorio.tar.gz && rm factorio.tar.gz && mv factorio /factorio
fi
if [ "$CLUSTERIO_MODE" = "controller" ] || [ "$CLUSTERIO_MODE" = "standalone" ]; then
    if [ ! -f /clusterio/config-controller.json ]; then
        myIP=$(curl --silent https://api.ipify.org/)
        npm init "@clusterio" -- --mode $CLUSTERIO_MODE --admin $CLUSTERIO_ADMIN --http-port 8080 --publicAddress $myIP --no-download-headless --factorio-dir /factorio/factorio --remoteNpm --plugins $CLUSTERIO_PLUGINS
    fi
    if [ "$CLUSTERIO_MODE" = "standalone" ]; then
        /bin/sh ./run-host.sh &
    fi
    /bin/sh ./run-controller.sh
elif [ "$CLUSTERIO_MODE" = "host" ]; then
    if [ ! -f /clusterio/config-host.json ]; then
        npm init "@clusterio" -- --mode host --controller-token $CLUSTERIO_HOST_CONTROLLER_TOKEN --controllerUrl $CLUSTERIO_HOST_CONTROLLER_URL --hostName $CLUSTERIO_HOST_NAME --no-download-headless --factorio-dir /factorio/factorio --remoteNpm --plugins $CLUSTERIO_PLUGINS
    fi
    /bin/sh ./run-host.sh
else
    echo "Invalid CLUSTERIO_MODE: $CLUSTERIO_MODE"
    exit 1
fi
