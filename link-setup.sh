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
link "$AGENTS/agents" "$HOME/.claude/agents"
link "$AGENTS/AGENTS.md" "$HOME/.claude/CLAUDE.md"

link "$AGENTS/skills" "$HOME/.gemini/config/skills"
link "$AGENTS/AGENTS.md" "$HOME/.gemini/config/AGENTS.md"

# Antigravity ignores agents with unknown frontmatter fields and wants
# <name>/agent.md, so generate those files instead of symlinking.
gen_agy_agents() {
  local src dir file out
  for src in "$REPO_DIR"/agents/*.md; do
    dir="$HOME/.gemini/config/agents/$(basename "$src" .md)"
    file="$dir/agent.md"
    out=$(awk '
      /^---$/ && c < 2 { c++; print; next }
      c == 1 { if ($0 ~ /^(name|description):/) print; next }
      { print }
    ' "$src")
    if [ -f "$file" ] && [ ! -L "$file" ] && [ "$out" = "$(cat "$file")" ]; then
      continue
    fi
    mkdir -p "$dir"
    rm -f "$file"
    printf '%s\n' "$out" > "$file"
    echo "generated $file"
  done
}

gen_agy_agents

# add a new tool here, same pattern, e.g.:
# link "$AGENTS/skills" "$HOME/.codex/skills"
# link "$AGENTS/AGENTS.md" "$HOME/.codex/AGENTS.md"
