#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
target_dir="${CODEX_HOME:-$HOME/.codex}/pets/mimi"

mkdir -p "$target_dir"
cp "$repo_dir/pet/pet.json" "$repo_dir/pet/spritesheet.webp" "$target_dir/"

printf 'Installed Mimi to %s\n' "$target_dir"
printf 'Restart Codex, then select Mimi from custom pets.\n'
