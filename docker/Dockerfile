FROM node:lts-alpine as nuxtBuild

WORKDIR /app

RUN wget -q https://github.com/pnpm/pnpm/releases/latest/download/pnpm-linuxstatic-x64 -O /bin/pnpm && chmod +x /bin/pnpm

COPY ./ ./

RUN set -e \
    && pnpm install \
    && pnpm run build


FROM node:lts-alpine

ENV HOST=0.0.0.0

WORKDIR /app

COPY --from=nuxtBuild /app/docker/nuxt-entrypoint.sh /usr/local/bin/
COPY --from=nuxtBuild /bin/pnpm /bin/
COPY --from=nuxtBuild /app/package.json ./
COPY --from=nuxtBuild /app/.output ./.output

RUN chmod +x /usr/local/bin/nuxt-entrypoint.sh

ENTRYPOINT ["nuxt-entrypoint.sh"]
