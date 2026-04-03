---
status: complete
owner: janus
priority: high
description: Janus self-commit command with AI-assisted commit message generation
completed: 2026-04-03
---

## Purpose

Janus needs to commit changes to her own repository. This command uses OpenCode to generate thoughtful, event-driven commit messages that explain the stream signal or event that triggered the change.

## Interface

**Command:** `janus commit self`

**Arguments:** None (commits staged files interactively)

**Output:** Git commit confirmation and commit hash

## Specification

**Input:** Staged files in ~/.janus/

**Output:** Committed changes with meaningful commit message

**Behavior:**
- Change to Janus home directory (~/.janus/)
- Review staged files
- Use OpenCode (Claude model) to generate commit message
- Prompt emphasizes:
  - Signal/event that triggered the change
  - What changed and why it matters
  - Concise, imperative mood subject line (<72 chars)
  - Explanatory body
- If no files staged: report and exit cleanly

**Constraints:**
- Never push automatically (commit only)
- Always include 'why' not just 'what'
- Focus on stream events/signals that triggered work

## Implementation

Implemented in `commands/commit/self/command.sh`. Uses `opencode --model` CLI to invoke Claude for commit message generation.

## Testing

Tested with various staged file scenarios. Produces readable, meaningful commit messages.

## Status Note

Production-ready. Used for Janus's own repository changes.
