#!/usr/bin/env bash
set -euo pipefail
# Janus — interactive or prompt-driven
# Usage: janus                               → interactive Claude Code session
#        PROMPT="check for drift" janus      → non-interactive, identity + prompt
#        echo "check for drift" | janus      → non-interactive, stdin

IDENTITY="$HOME/.janus/memories/001-identity.md"

PROMPT="${PROMPT:-}"
if [ -z "$PROMPT" ] && [ ! -t 0 ]; then
  PROMPT="$(cat)"
fi

cd "$HOME/.janus"

if [ -n "$PROMPT" ]; then
  exec opencode run --model opencode/big-pickle "$(cat "$IDENTITY")

$PROMPT"
else
  exec claude . --model sonnet
fi
