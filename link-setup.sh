#!/usr/bin/env bash
# Recreates the ~/.agents symlink setup for this repo.
# Safe to re-run: skips links already correct, backs up anything real.
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
AGENTS="$HOME/.agents"

link() {
  local target=$1 path=$2
  if [ -L "$path" ] && [ "$(readlink "$path")" = "$target" ]; then
    return
  fi
  if [ -e "$path" ] || [ -L "$path" ]; then
    mv "$path" "${path}.bak.$(date +%s)"
    echo "backed up $path"
  fi
  mkdir -p "$(dirname "$path")"
  ln -s "$target" "$path"
  echo "linked $path -> $target"
}

link "$REPO_DIR" "$AGENTS"

link "$AGENTS/skills" "$HOME/.claude/skills"
link "$AGENTS/AGENTS.md" "$HOME/.claude/CLAUDE.md"

# add a new tool here, same pattern, e.g.:
# link "$AGENTS/skills" "$HOME/.codex/skills"
# link "$AGENTS/AGENTS.md" "$HOME/.codex/AGENTS.md"
