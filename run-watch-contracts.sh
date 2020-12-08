#!/bin/sh
set -x
cd /home/demo

generateStubs () {
  rm -rf $STUBS_PATH/mappings \
    && rm -rf $STUBS_PATH/contracts \
    && gradle generateClientStubs \
    && curl -X POST http://localhost:8080/__admin/reset \
    || echo "Failed to update stubs"
}

# initial stub generation
generateStubs

# inotifywait will be very chatty for lots of files so need to come up with better solution
# Maybe pull in node or maybe java has a better file watching system we can kick off
# with gradle task
inotifywait -m -r -e modify -e create -e delete -e move $CONTRACTS_PATH |
  while read path action file; do
    echo "$path $action $file"
    generateStubs
  done