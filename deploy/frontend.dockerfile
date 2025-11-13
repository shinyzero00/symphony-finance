from scratch as clone

add https://github.com/nikitaLomeiko/vtb-api-hack_2025.git#b28253905c7423c596c1500477f09809ccdfc636 /src
# workdir /src

from node:24-alpine3.21 as build

workdir /app
copy --from=clone /src/yarn.lock /src/package.json .
run --mount=type=cache,target=/usr/local/share/.cache/yarn yarn install
copy --from=clone /src/ .
run yarn build

from nginx:mainline

copy --from=build /app/dist /usr/share/nginx/html
