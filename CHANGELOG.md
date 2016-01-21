# CHANGELOG.md for denv
## 0.2.3
- Improve help message of CLI tool.

## 0.2.2
- Env vars are removed on loading when they are removed from `.env` file. This is useful when use unicorn's graceful reloading.

## 0.2.1
- Add command line tool (`denv`)

## 0.2.0
- Behaves as over-write.
- Add `Denv.build_env(filename)` to load and get env hash.
