#!/usr/bin/env bash
set -euo pipefail

scope="global"

if [[ "${1:-}" == "--local" ]]; then
  scope="local"
elif [[ "${1:-}" == "--global" ]]; then
  scope="global"
elif [[ $# -gt 0 ]]; then
  echo "Usage: $0 [--global|--local]" >&2
  exit 1
fi

if ! command -v git >/dev/null 2>&1; then
  echo "git is required but was not found in PATH" >&2
  exit 1
fi

# Clean up the previous alias name if it existed.
git config --"${scope}" --unset alias.git-discard >/dev/null 2>&1 || true

git config --"${scope}" alias.discard '!git reset --hard HEAD && git clean -fd'

cat <<EOF
Configured Git alias "discard" in ${scope} config.
Use it inside any repository with:

  git discard

This will reset tracked files to HEAD and remove untracked files/directories.
EOF
