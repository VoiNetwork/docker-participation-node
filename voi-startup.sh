#!/bin/bash

while ! goal node status
do
  sleep 5
  echo "Waiting for Algod"
done

## Catchup
if [ "$VOI_FAST_CATCHUP" = '1' ]; then
  echo "fast catchup enabled"
  myNodeRound=`goal node lastround`
  blockchainRoundMath=$(curl -s https://testnet-api.voi.nodly.io/v2/status | jq -r '.["last-round"]' )" - 1000"
  blockchainRound=$(echo $blockchainRoundMath | bc)

  echo "catchup check: my round is $myNodeRound, blockchain round is $blockchainRound"
  if [ "$myNodeRound" -lt "$blockchainRound" ]; then
	  echo "Executing catchup script because my current round is $myNodeRound"
	  catchup=$(curl -s https://testnet-api.voi.nodly.io/v2/status | jq -r '.["last-catchpoint"]')
	  sleep 10s
	  echo "going to run 'goal node catchup $catchup'"
	  goal node catchup $catchup || error_code=$?
	  if [ $error_code_int -ne 0 ]; then
		  echo "failed to start catchup";
		  exit 1;
	  fi
  fi
fi

while true; do date; goal node status; sleep 600;done