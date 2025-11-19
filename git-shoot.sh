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

# Replace any previous definition with a POSIX-compatible version.
git config --"${scope}" --unset alias.shoot >/dev/null 2>&1 || true

git config --"${scope}" alias.shoot '!f(){ msg="$*"; [ -n "$msg" ] || { echo "Usage: git shoot \"commit message\""; return 1; }; git add . && git commit -am "$msg" && git push; }; f'

cat <<EOF
Configured Git alias "shoot" in ${scope} config.
Use it inside any repository with:

  git shoot "your commit message"

This will run: git add . && git commit -am "<msg>" && git push
EOF
