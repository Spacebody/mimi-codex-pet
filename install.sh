#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Install a Mimi Codex pet version.

Usage:
  ./install.sh [v1|v2]
  ./install.sh --version <v1|v2>
  ./install.sh --list

V2 is installed by default. Set CODEX_HOME to override the Codex data directory.
EOF
}

selected_version="v2"

while (($# > 0)); do
  case "$1" in
    v1|v2)
      selected_version="$1"
      ;;
    --version)
      shift
      if (($# == 0)); then
        printf 'Missing value for --version.\n' >&2
        usage >&2
        exit 2
      fi
      selected_version="$1"
      ;;
    --list)
      printf 'v1  legacy 8x9 atlas\n'
      printf 'v2  extended 8x11 atlas (default)\n'
      exit 0
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      printf 'Unknown argument: %s\n' "$1" >&2
      usage >&2
      exit 2
      ;;
  esac
  shift
done

case "$selected_version" in
  v1)
    expected_width=1536
    expected_height=1872
    ;;
  v2)
    expected_width=1536
    expected_height=2288
    ;;
  *)
    printf 'Unsupported Mimi version: %s (expected v1 or v2)\n' "$selected_version" >&2
    exit 2
    ;;
esac

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source_dir="$repo_dir/versions/$selected_version/pet"
manifest_path="$source_dir/pet.json"
spritesheet_path="$source_dir/spritesheet.webp"

if [[ ! -f "$manifest_path" || ! -f "$spritesheet_path" ]]; then
  printf 'Mimi %s package is incomplete: %s\n' "$selected_version" "$source_dir" >&2
  exit 1
fi

if command -v jq >/dev/null 2>&1; then
  manifest_id="$(jq -r '.id // empty' "$manifest_path")"
  spritesheet_name="$(jq -r '.spritesheetPath // empty' "$manifest_path")"
  sprite_version="$(jq -r '.spriteVersionNumber // 1' "$manifest_path")"

  if [[ "$manifest_id" != "mimi" || "$spritesheet_name" != "spritesheet.webp" ]]; then
    printf 'Mimi %s manifest has an unexpected id or spritesheet path.\n' "$selected_version" >&2
    exit 1
  fi

  if [[ "$selected_version" == "v2" && "$sprite_version" != "2" ]]; then
    printf 'Mimi V2 manifest must declare spriteVersionNumber 2.\n' >&2
    exit 1
  fi
fi

if command -v sips >/dev/null 2>&1; then
  actual_width="$(sips -g pixelWidth "$spritesheet_path" | awk '/pixelWidth:/ {print $2}')"
  actual_height="$(sips -g pixelHeight "$spritesheet_path" | awk '/pixelHeight:/ {print $2}')"

  if [[ "$actual_width" != "$expected_width" || "$actual_height" != "$expected_height" ]]; then
    printf 'Mimi %s spritesheet has unexpected dimensions: %sx%s (expected %sx%s).\n' \
      "$selected_version" "$actual_width" "$actual_height" "$expected_width" "$expected_height" >&2
    exit 1
  fi
fi

codex_data_dir="${CODEX_HOME:-$HOME/.codex}"
target_dir="$codex_data_dir/pets/mimi"

mkdir -p "$target_dir"
cp "$manifest_path" "$spritesheet_path" "$target_dir/"

printf 'Installed Mimi %s to %s\n' "$selected_version" "$target_dir"
printf 'Restart Codex, then select Mimi from custom pets.\n'
