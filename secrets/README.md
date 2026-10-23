# Secrets

This directory contains encrypted secrets managed by [sops-nix](https://github.com/Mic92/sops-nix).

## Structure

```
secrets/
├── auth.yaml          # Shared authentication secrets
├── sam/               # Host-specific secrets for sam
└── dean/              # Host-specific secrets for dean
```

## Encryption

Secrets are encrypted with [age](https://github.com/FiloSottile/age). Encryption rules are defined in `.sops.yaml` at the repository root.

### Key access rules

- `secrets/sam/*.yaml` - decryptable by sam, dean, adega_sam, adega_dean
- `secrets/dean/*.yaml` - decryptable by dean, adega_sam, adega_dean
- `secrets/*.yaml` (shared) - decryptable by sam, adega_sam, adega_dean

## Usage

### Editing secrets

Use `sops` to edit encrypted files:

```bash
sops secrets/auth.yaml
sops secrets/sam/some-secret.yaml
```

### Adding new secrets

1. Create/edit the file with `sops`
2. Ensure it follows the path pattern in `.sops.yaml`
3. Reference in Nix configuration using sops-nix options

### Adding a new host

When adding a new host, update `.sops.yaml`:

1. Add the host's age public key
2. Add adega's key for that host if needed
3. Add creation rules for host-specific secret paths

## Important Notes

- Never commit unencrypted secrets
- Private age keys must be kept secure and not committed to the repo
- The keys referenced in `.sops.yaml` are public keys used for encryption
