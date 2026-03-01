# repo-settings-as-code

A composite GitHub Action that manages GitHub repository settings with OpenTofu.

## Usage

```yaml
- uses: actions/checkout@de0fac2e4500dabe0009e67214ff5f5447ce83dd # v6.0.2
- uses: lens0021/repo-settings-as-code@66113512d5cbdcf36a9d6029dba919e5e79cd636 # v1.0.0
  with:
    github-token: ${{ secrets.GITHUB_TOKEN }}
```

## Required permissions

```yaml
permissions:
  issues: write         # drift issue
  pull-requests: write  # plan comment
```

### Local state

If you store Terraform state in the repository, also add:

```yaml
permissions:
  contents: write
```

> [!WARNING]
> Storing state in git is convenient for simple setups but has
> trade-offs: state files may contain sensitive values in plaintext,
> and concurrent runs can cause conflicts. Consider a remote backend
> (e.g. S3, Terraform Cloud) for shared or production use.

## Inputs

| Input | Required | Default | Description |
|---|---|---|---|
| `github-token` | Yes | | GitHub token |
| `working-directory` | No | `.github/tf` | Directory containing OpenTofu configuration |

## Behavior

- On **pull request**: runs `tofu plan` and comments the result on the PR
- On **push / workflow_dispatch**: runs `tofu plan` and opens or closes a drift
  issue accordingly
- Import-only plans are applied automatically before the main plan step — add
  [`import` blocks](https://opentofu.org/docs/language/import/) to your configuration
  to bring existing resources under management without triggering drift alerts
