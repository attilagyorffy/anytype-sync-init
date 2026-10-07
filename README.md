# anytype-sync-init

The config generator of
[anyproto/any-sync-dockercompose](https://github.com/anyproto/any-sync-dockercompose)
v8.0.1 (commit `8035d68`), built once in CI and published to GHCR, so that a
TrueNAS custom app, which cannot build images, can run it.

`docker-generateconfig/` is the upstream folder at that tag, without the
MinIO migration scripts (`s3-guard.sh`, `migrate-s3.sh`), which a new
network does not need. The Dockerfile is upstream's `Dockerfile-any-sync-init`
with two changes: the base image `any-sync-tools` is pinned to v0.7.0 by
digest, and `yq` is pinned to v4.54.1 instead of "latest".

## Use

Run it once against an empty directory that holds the network's `.env`:

```sh
docker run --rm \
  -v /path/to/network/.env:/code/.env:ro \
  -v /path/to/network/etc:/code/etc \
  -v /path/to/network/storage:/code/storage \
  ghcr.io/attilagyorffy/anytype-sync-init@sha256:<digest>
```

It writes `storage/docker-generateconfig/` (the network identity: keep it
secret and back it up) and `etc/` (the node configs and `client.yml`). Run
again, it keeps the saved identity and only regenerates `etc/`.

## License

MIT, as upstream; see `LICENSE.md`.
