# 🐳 @misaon/nuxt-docker

> Sample Nuxt 3 project running on Docker. With tweaks and PNPM support!

## Usage

For **development**, simple run:

```sh
docker compose up -d
```

For **production**, run:

```sh
docker compose build
docker run -p 3000:3000 nuxt-docker:latest
```

## Docker source files

- `docker-compose.yml`
- `docker`
  - `Dockerfile`
  - `nuxt-entrypoint.sh`

## License

Made with 🧡 by [@misaon](https://github.com/misaon)
