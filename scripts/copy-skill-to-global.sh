#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd -- "${SCRIPT_DIR}/.." && pwd)"
SOURCE_ROOT="${REPO_ROOT}/.agents/skills"
DEST_ROOT="${HOME}/.agents/skills"
FORCE=0

usage() {
  cat <<'EOF'
Usage:
  scripts/copy-skill-to-global.sh [--dest PATH] [--force] [--list] <skill-name> [skill-name...]

Examples:
  scripts/copy-skill-to-global.sh exploring
  scripts/copy-skill-to-global.sh --force exploring planning
  scripts/copy-skill-to-global.sh --dest /tmp/global-skills gitnexus-cli

Options:
  --dest PATH   Copy into PATH instead of ~/.agents/skills
  --force       Replace the destination skill if it already exists
  --list        Print all available skill names and exit
  -h, --help    Show this help text
EOF
}

list_skills() {
  find "${SOURCE_ROOT}" -type f -name 'SKILL.md' -print \
    | while IFS= read -r skill_file; do
        basename "$(dirname "${skill_file}")"
      done \
    | sort -u
}

resolve_skill_dir() {
  local requested="$1"
  local matches=()

  while IFS= read -r skill_file; do
    matches+=("$(dirname "${skill_file}")")
  done < <(find "${SOURCE_ROOT}" -type f -path "*/${requested}/SKILL.md" -print)

  if [[ "${#matches[@]}" -eq 0 ]]; then
    echo "Skill not found: ${requested}" >&2
    return 1
  fi

  if [[ "${#matches[@]}" -gt 1 ]]; then
    echo "Skill name is ambiguous: ${requested}" >&2
    printf 'Matches:\n' >&2
    printf '  %s\n' "${matches[@]}" >&2
    return 1
  fi

  printf '%s\n' "${matches[0]}"
}

copy_skill() {
  local requested="$1"
  local source_dir
  local dest_dir

  source_dir="$(resolve_skill_dir "${requested}")"
  dest_dir="${DEST_ROOT}/${requested}"

  mkdir -p "${DEST_ROOT}"

  if [[ -e "${dest_dir}" ]]; then
    if [[ "${FORCE}" -ne 1 ]]; then
      echo "Destination exists, use --force to replace: ${dest_dir}" >&2
      return 1
    fi
    rm -rf "${dest_dir}"
  fi

  cp -R "${source_dir}" "${dest_dir}"
  echo "Copied ${requested} -> ${dest_dir}"
}

main() {
  local skill_names=()

  while [[ "${#}" -gt 0 ]]; do
    case "$1" in
      --dest)
        [[ "${#}" -ge 2 ]] || { echo "--dest requires a path" >&2; exit 1; }
        DEST_ROOT="$2"
        shift 2
        ;;
      --force)
        FORCE=1
        shift
        ;;
      --list)
        list_skills
        exit 0
        ;;
      -h|--help)
        usage
        exit 0
        ;;
      --*)
        echo "Unknown option: $1" >&2
        usage >&2
        exit 1
        ;;
      *)
        skill_names+=("$1")
        shift
        ;;
    esac
  done

  if [[ "${#skill_names[@]}" -eq 0 ]]; then
    usage >&2
    exit 1
  fi

  for skill_name in "${skill_names[@]}"; do
    copy_skill "${skill_name}"
  done
}

main "$@"
