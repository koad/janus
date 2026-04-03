---
status: complete
owner: janus
priority: critical
description: Maintain Janus canonical identity document and cryptographic keys
completed: 2026-04-03
---

## Purpose

Janus maintains its canonical identity—the authoritative statement of what Janus is, where it operates, and who authorizes it. This document (in `identity/`) provides the trust anchor for all of Janus's signals and alerts.

## Specification

**Input:** Entity name (janus), role (stream watcher), scope (platform monitoring)

**Output:** Canonical identity document, cryptographic keys (Ed25519, ECDSA, RSA, DSA)

**Behavior:**
- Maintain `identity/canonical.md` as the authoritative identity statement
- Include:
  - Entity name: `janus`
  - Role: Stream watcher for koad:io ecosystem
  - Scope: Monitor GitHub feeds, file alerts, maintain watch logs
  - Authority chain: koad → Juno → Janus
  - Natural home: fourty4 (Mac Mini, always-on)
  - Git identity: author name and email for commits
- Store cryptographic keys in `id/` directory:
  - Private keys: Ed25519, ECDSA, RSA, DSA (600 perms)
  - Public keys: corresponding .pub files (644 perms)
- Sign canonical identity document (canonical.md.asc) to establish trust

**Edge cases:**
- Key rotation → update `id/` directory, re-sign canonical doc
- Identity dispute → escalate to koad via Juno

## Implementation

Canonical document stored at `identity/canonical.md`. Signed with Janus private key. Git identity configured in `.env` and leveraged for all commits.

## Dependencies

- Identity directory (identity/)
- Cryptographic keys (id/)
- GnuPG for signing (optional, can use openssl)
- Git configured with entity credentials

## Testing

Identity document is readable and complete. Signature (if present) validates correctly. Keys are usable for signing and authentication.

## Status Note

Production-ready. Created as entity identity anchor (per VESTA-SPEC-001).
