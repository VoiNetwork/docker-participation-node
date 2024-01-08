ARG BASE_ALGORAND_VERSION=3.20.1
FROM algorand/algod:$BASE_ALGORAND_VERSION-stable
LABEL "network.voi"="Voi Network"
LABEL version=$BASE_ALGORAND_VERSION

ENV NETWORK=voitest \
    GENESIS_ADDRESS=https://testnet-api.voi.nodly.io \
    TELEMETRY_NAME="${HOSTNAME}" \
    ## Mimics the behavior of Algorand's fast catchup variable, though they are less aggressive in catchup up when invoking `goal node catchup`
    VOI_FAST_CATCHUP=1

COPY ./config.json /etc/algorand/config.json
COPY ./start.sh /node/run/start.sh
COPY ./voi-startup.sh /node/run/voi-catchup.sh

RUN apt-get update && apt-get dist-upgrade -y && apt install -y jq bc curl

CMD "/node/run/start.sh"