#!/usr/bin/env bash
set -euo pipefail

TARGET=""
INSTALL_SKILLS=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    -t|--target)
      TARGET="$2"
      shift 2
      ;;
    --target=*)
      TARGET="${1#*=}"
      shift
      ;;
    --install-skills)
      INSTALL_SKILLS=1
      shift
      ;;
    *)
      echo "Unknown option: $1" >&2
      exit 1
      ;;
  esac
done

if [[ -z "$TARGET" ]]; then
  echo "Usage: $0 --target=<path> [--install-skills]" >&2
  exit 1
fi

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SOURCE_ROOT="$REPO_ROOT/.codex"
TARGET="$(cd "$TARGET" && pwd)"
TARGET_CODEX="$TARGET/.codex"

mkdir -p "$TARGET_CODEX"

for name in commands subagents skill-specs hooks skills; do
  if [[ -d "$SOURCE_ROOT/$name" ]]; then
    rm -rf "$TARGET_CODEX/$name"
    cp -R "$SOURCE_ROOT/$name" "$TARGET_CODEX/$name"
    echo "Synced: $name"
  fi
done

if [[ -f "$SOURCE_ROOT/settings.json" ]]; then
  cp "$SOURCE_ROOT/settings.json" "$TARGET_CODEX/settings.json"
  echo "Synced: settings.json"
fi

if [[ "$INSTALL_SKILLS" == "1" ]]; then
  "$REPO_ROOT/scripts/install-codex-skills.sh"
fi

echo
echo "Codex tool assets initialized successfully."
echo "Target: $TARGET_CODEX"