#!/usr/bin/env bash
set -euo pipefail

TARGET="${1:-}"
REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SOURCE_ROOT="$REPO_ROOT/.codex/skills"

if [[ ! -d "$SOURCE_ROOT" ]]; then
  echo "Repo skill source not found: $SOURCE_ROOT" >&2
  exit 1
fi

if [[ -z "$TARGET" ]]; then
  if [[ -n "${CODEX_HOME:-}" ]]; then
    TARGET="$CODEX_HOME/skills"
  else
    TARGET="$HOME/.codex/skills"
  fi
fi

mkdir -p "$TARGET"

for skill_dir in "$SOURCE_ROOT"/*; do
  [[ -d "$skill_dir" ]] || continue
  name="$(basename "$skill_dir")"
  destination="$TARGET/$name"
  rm -rf "$destination"
  cp -R "$skill_dir" "$destination"
  echo "Installed skill: $name -> $destination"
done

echo
echo "Codex skills installed successfully."
echo "Source: $SOURCE_ROOT"
echo "Target: $TARGET"