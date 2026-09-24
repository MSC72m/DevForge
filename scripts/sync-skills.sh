#!/usr/bin/env bash
set -euo pipefail

# DevForge Global Agent Environment Setup & Sync
# Links ~/.agents/skills to pi, omp, claude, opencode, and codex

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
AGENTS_DIR="${HOME}/.agents/skills"

echo "==> Ensuring ~/.agents/skills directory exists..."
mkdir -p "${AGENTS_DIR}"

echo "==> Copying tracked skills to ~/.agents/skills..."
cp -R "${ROOT_DIR}/skills/"* "${AGENTS_DIR}/"

echo "==> Symlinking skills into harness directories..."

# 1. Pi
mkdir -p "${HOME}/.pi/agent"
rm -rf "${HOME}/.pi/agent/skills"
ln -sfn "${AGENTS_DIR}" "${HOME}/.pi/agent/skills"

# 2. OMP (OhMyPi)
mkdir -p "${HOME}/.omp/agent"
rm -rf "${HOME}/.omp/agent/skills"
ln -sfn "${AGENTS_DIR}" "${HOME}/.omp/agent/skills"

# 3. Claude Code
mkdir -p "${HOME}/.claude"
rm -rf "${HOME}/.claude/skills"
ln -sfn "${AGENTS_DIR}" "${HOME}/.claude/skills"

# 4. OpenCode
mkdir -p "${HOME}/.config/opencode"
rm -rf "${HOME}/.config/opencode/skills"
ln -sfn "${AGENTS_DIR}" "${HOME}/.config/opencode/skills"

# 5. Codex
mkdir -p "${HOME}/.codex/skills"
for skill_dir in "${AGENTS_DIR}"/*; do
  skill_name=$(basename "${skill_dir}")
  if [ ! -e "${HOME}/.codex/skills/${skill_name}" ]; then
    ln -sfn "${skill_dir}" "${HOME}/.codex/skills/${skill_name}"
  fi
done

echo "==> Syncing MCP server definitions..."
mkdir -p "${HOME}/.omp/agent"
if [ -f "${ROOT_DIR}/configs/mcp/omp-mcp.json" ]; then
  cp -n "${ROOT_DIR}/configs/mcp/omp-mcp.json" "${HOME}/.omp/agent/mcp.json" 2>/dev/null || true
fi
if [ -f "${ROOT_DIR}/configs/mcp/pi-mcp.json" ]; then
  cp -n "${ROOT_DIR}/configs/mcp/pi-mcp.json" "${HOME}/.pi/agent/mcp.json" 2>/dev/null || true
fi

echo "==> Environment ready and synchronized!"
