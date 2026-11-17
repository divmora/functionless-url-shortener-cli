# Functionless URL Shortener CLI (`shorten`)

[![Latest Release](https://img.shields.io/github/v/release/divmora/functionless-url-shortener-cli?logo=github)](https://github.com/divmora/functionless-url-shortener-cli/releases)
[![License: Apache 2.0](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![CI](https://github.com/divmora/functionless-url-shortener-cli/actions/workflows/ci.yml/badge.svg)](https://github.com/divmora/functionless-url-shortener-cli/actions)

Command-line client for managing links on a [Functionless URL Shortener](https://github.com/divmora/functionless-url-shortener) deployment.

The management API (`/api/*`) only accepts AWS SigV4-signed requests from identities in your AWS Organization. `shorten` signs requests for you using the standard AWS credential chain (environment variables, shared profiles, IAM Identity Center / SSO, instance roles), so you never have to hand-craft SigV4 requests.

---

## Install

**Prebuilt binaries** (Linux, macOS, Windows; amd64 and arm64) are attached to each [GitHub release](https://github.com/divmora/functionless-url-shortener-cli/releases).

**With Go 1.26+:**

```bash
go install github.com/divmora/functionless-url-shortener-cli/cmd/shorten@latest
```

---

## Usage

```bash
# Create a link (a random 7-character ID is generated if --id is omitted)
shorten create https://example.com/very/long/path --id launch --ttl 604800

# Look up a link
shorten get launch

# Delete a link
shorten delete launch

# JSON output for scripting
shorten get launch --output json

# Version and build info
shorten version
```

### Connecting to a deployment

By default the CLI reads the management endpoint from the `ManagementApiEndpoint` output of the CloudFormation stack (default stack name `URLShortener`). Override with:

| Flag | Env var | Description |
| :--- | :--- | :--- |
| `--stack` | `SHORTEN_STACK` | Stack to read the endpoint from (default `URLShortener`). |
| `--endpoint` | `SHORTEN_ENDPOINT` | Management API endpoint; skips the stack lookup. |
| `--region` | `AWS_REGION` | AWS region (inferred from `--endpoint` when possible). |
| `--profile` | `AWS_PROFILE` | AWS shared config profile, e.g. an IAM Identity Center profile. |
| `--output` | | `text` (default) or `json`. |

Exit codes: `0` success, `1` error, `2` usage error, `3` link not found, `4` link ID already exists.

> [!NOTE]
> The CLI calls the API Gateway (`execute-api`) endpoint directly rather than CloudFront: CloudFront rewrites the `Host` header, which invalidates SigV4 signatures. Looking up the endpoint from the stack additionally requires `cloudformation:DescribeStacks`; use `--endpoint` if the caller lacks it.

### Required IAM permissions

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "execute-api:Invoke",
      "Resource": [
        "arn:aws:execute-api:*:*:*/*/POST/api",
        "arn:aws:execute-api:*:*:*/*/GET/api/*",
        "arn:aws:execute-api:*:*:*/*/DELETE/api/*"
      ]
    }
  ]
}
```

The calling identity must also belong to the AWS Organization configured on the deployment.

### Compatibility

`delete` and stack-based endpoint discovery need a deployment from [functionless-url-shortener](https://github.com/divmora/functionless-url-shortener) **v0.4.0 or later**.

---

## Development

```bash
make test    # go test ./...
make lint    # golangci-lint
make build   # ./bin/shorten
```

Commits and PR titles follow [Conventional Commits](https://www.conventionalcommits.org/); releases and binaries are produced by Release Please and GoReleaser.

---

## License

[Apache License 2.0](LICENSE)
