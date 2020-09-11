# Stack starting

## Start the APIs

All APIs must be started with gateway mode enabled, using the following environment variables :

```toml
MYRTEA_API_ENABLE_SECURITY=true
MYRTEA_API_ENABLE_GATEWAY_MODE=true
MYRTEA_API_ENABLE_CORS=true
```

... Start the auth-api

... Start the engine-api

... Start the modeler-api

## Start the gateway

Download [nginx-api-gateway.conf](assets/nginx-api-gateway.conf)

```sh
docker run \
    --rm \
    --network=host \
    --name nginx-api-gateway \
    -v $(PWD)/nginx-api-gateway.conf:/etc/nginx/conf.d/default.conf \
    nginx:alpine
```

## Start the frontend

Edit the file `src/environments/environment.ts` and replace :

```ts
export const environment = { ... }
```

by

```ts
export const environment = {
  production: false,
  URL: 'http://localhost:9010/api/v4',
  defaultLanguage: 'fr',
  clientLogo: '../assets/images/LogoWebApp.png',
  WS_URL: 'ws://localhost:9010/api/v4'
};
```

The URL variable now targets the gateway port (`9010`).

... Start the web interface project
