# Setup GPG Signing Action

This composite action configures GPG signing for commits made by GitHub Actions workflows.

## Purpose

Enables automated workflows to sign commits with GPG, ensuring compliance with the repository's
GPG signing requirements documented in `SECURITY.md`.

## Inputs

| Input | Description | Required |
|-------|-------------|----------|
| `gpg_private_key` | GPG private key for signing commits | Yes |
| `gpg_passphrase` | Passphrase for the GPG private key | Yes |

## Usage

Add this action to your workflow before any steps that create commits:

```yaml
- name: Setup GPG signing
  uses: ./.github/actions/setup-gpg-signing
  with:
    gpg_private_key: ${{ secrets.GPG_PRIVATE_KEY }}
    gpg_passphrase: ${{ secrets.GPG_PASSPHRASE }}
```

## Requirements

- The workflow must have `contents: write` permission to push signed commits
- The GPG key must be added to the GitHub account settings
- Repository secrets must contain:
  - `GPG_PRIVATE_KEY`: The private GPG key
  - `GPG_PASSPHRASE`: The passphrase for the GPG key

## Implementation

This action uses [crazy-max/ghaction-import-gpg](https://github.com/crazy-max/ghaction-import-gpg)
to import the GPG key and configure Git to sign commits globally.

## GPG Key Configuration

- **GPG Key ID**: `749C2643F7EF18D6`
- **Git User Email**: `238336761+hummbl-dev@users.noreply.github.com`
- **Git User Name**: `GitHub Actions Bot`

## Security

- Never commit GPG private keys to the repository
- Always use repository secrets for sensitive values
- The GPG key is imported only for the duration of the workflow run
