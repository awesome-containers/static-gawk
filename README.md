# Statically linked Gawk

Statically linked [Gawk] container image with [Bash]

> 1.7M

```bash
ghcr.io/awesome-containers/static-gawk:latest
ghcr.io/awesome-containers/static-gawk:5.2.1

docker.io/awesomecontainers/static-gawk:latest
docker.io/awesomecontainers/static-gawk:5.2.1
```

Slim statically linked [Gawk] container image with [Bash] packaged with [UPX]

> 849K

```bash
ghcr.io/awesome-containers/static-gawk:latest-slim
ghcr.io/awesome-containers/static-gawk:5.2.1-slim

docker.io/awesomecontainers/static-gawk:latest-slim
docker.io/awesomecontainers/static-gawk:5.2.1-slim
```

[Gawk]: https://www.gnu.org/software/gawk/
[Bash]: https://github.com/awesome-containers/static-bash
[UPX]: https://upx.github.io/

<!--
```bash
image="localhost/${PWD##*/}"

podman build -t "$image:latest" .
podman build -t "$image:latest-slim" -f Containerfile-slim \
  --build-arg STATIC_GAWK_IMAGE="$image" \
  --build-arg STATIC_GAWK_VERSION=latest --no-cache .

echo "$image:latest"
podman inspect "$image:latest" | jq '.[].Size' | numfmt --to=iec
echo "$image:latest-slim"
podman inspect "$image:latest-slim" | jq '.[].Size' | numfmt --to=iec

```
-->
