# Agent Guidelines for Functionless URL Shortener CLI

Go CLI (`shorten`) for the [Functionless URL Shortener](https://github.com/divmora/functionless-url-shortener) management API.

## Layout
- `cmd/shorten`: argument parsing, output formatting, exit codes.
- `internal/client`: SigV4-signing HTTP client (`execute-api` service). Always call the `execute-api` endpoint, never CloudFront (CloudFront rewrites `Host` and breaks signatures).
- `internal/discover`: resolves the endpoint from the CloudFormation `ManagementApiEndpoint` stack output.

## API contract
The API lives in `api.yaml` in the infrastructure repo. Quirks the client relies on:
- `GET /api/{id}` returns `200` with empty fields for a missing link; the client maps that to `ErrNotFound`.
- `POST /api` returns `422` when the ID already exists.
- `DELETE /api/{id}` returns `404` when the link doesn't exist.

## Conventions
- Conventional Commits (`feat:`, `fix:`, `docs:`, `chore:`); Release Please + GoReleaser handle versions and binaries.
- Verify with `make lint test` before pushing.
