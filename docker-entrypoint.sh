#!/bin/bash

set -m

# run wiremock service (default command for container)
exec "$@" &
/home/demo/run-watch-contracts.sh

fg %1
