# repo-settings-as-code

A composite GitHub Action that manages GitHub repository settings with OpenTofu.

## Usage

```yaml
- uses: actions/checkout@de0fac2e4500dabe0009e67214ff5f5447ce83dd # v6.0.2
- uses: lens0021/repo-settings-as-code@main
  with:
    github-token: ${{ secrets.GITHUB_TOKEN }}
```

## Inputs

| Input | Required | Default | Description |
|---|---|---|---|
| `github-token` | Yes | | GitHub token |
| `working-directory` | No | `.github/tf` | Directory containing OpenTofu configuration |

## Behavior

- On **pull request**: runs `tofu plan` and comments the result on the PR
- On **push / workflow_dispatch**: runs `tofu plan` and opens or closes a drift
  issue accordingly
- Import-only plans are applied automatically before the main plan step
