#!/bin/bash

set -e

### Additional functions ###############################################################################################

waitForApi() {
    echo -e "[API] => Waiting for server API to be ready... (use '$ make slog' to see progress)"
    wait-for server:9000 -t 300 -- echo -e "[API] => Server API is ready!"
}

########################################################################################################################

if [[ $NODE_ENV = 'production' ]]; then
    UNIQUE_KEY=$(echo $RANDOM | md5sum | head -c 5)

    waitForApi

    if [[ -z $NUXT_PUBLIC_OXY_CDN_URL ]]; then
        NUXT_PUBLIC_OXY_REPLICA_ID="client-${UNIQUE_KEY}" node .output/server/index.mjs
    else
        NUXT_PUBLIC_OXY_REPLICA_ID="client-${UNIQUE_KEY}" NUXT_APP_CDN_URL="$(echo $NUXT_PUBLIC_OXY_CDN_URL)/" node .output/server/index.mjs
    fi
else
    pnpm install --shamefully-hoist
    /app/node_modules/.bin/nuxi prepare
    rm -rf /tmp/nitro/worker-*
    waitForApi
    pnpm run dev
fi
