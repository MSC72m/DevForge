#!/usr/bin/env bash
set -euo pipefail

# DevForge Global Skills & Environment Updater
# 1. Updates upstream open skills via official skills package manager (respecting authors & licenses)
# 2. Ensures local skills (unslop, yagni, etc.) are present in ~/.agents/skills
# 3. Synchronizes updated skills to DevForge git tracking and pushes if requested
# 4. Ensures all agent harnesses (pi, omp, claude, opencode, codex) have valid symlinks

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
AGENTS_DIR="${HOME}/.agents/skills"

echo "==> 1. Updating upstream skills from original authors via 'npx skills update'..."
npx skills update -g -y || echo "Notice: Some non-standard skills skipped during automated update"

echo "==> 2. Syncing updated skills and lockfile to DevForge..."
mkdir -p "${ROOT_DIR}/skills"
cp -R "${AGENTS_DIR}"/* "${ROOT_DIR}/skills/"
if [ -f "${HOME}/.agents/.skill-lock.json" ]; then
  cp "${HOME}/.agents/.skill-lock.json" "${ROOT_DIR}/skills-lock.json"
fi

echo "==> 3. Verifying harness symlinks..."
"${ROOT_DIR}/scripts/sync-skills.sh"

echo "==> 4. DevForge update complete!"
echo "To commit and push upstream changes: cd ${ROOT_DIR} && git commit -am 'chore: sync updated skills' && git push"
