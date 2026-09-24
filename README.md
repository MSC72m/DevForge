# DevForge

Unified environment, skills vault, configuration store, and reproduction harness for AI coding agents (`omp`, `pi`, `Claude Code`, `OpenCode`, and `Codex`).

---

## 1. Motivation & Architecture

Different AI coding harnesses store configuration and skills in different filesystem paths:
- **OMP**: `~/.omp/agent/skills/` & `~/.omp/agent/mcp.json`
- **Pi**: `~/.pi/agent/skills/` & `~/.pi/agent/settings.json`
- **Claude Code**: `~/.claude/skills/`
- **OpenCode**: `~/.config/opencode/skills/` & `opencode.json`
- **Codex**: `~/.codex/skills/` & `config.toml`

Maintaining separate sets of skills or diverging MCP/provider configs across these harnesses causes skill drift, missing tools, and broken prompt context.

### Single Source of Truth
DevForge centralizes all skills under `~/.agents/skills/`. All agent harnesses point directly to this central vault via managed symlinks. A skill added or tuned once is immediately accessible across all environments.

---

## 2. Directory Layout

```text
DevForge/
├── skills/                  # Master skill vault (75+ skills: SDD, TDD, YAGNI, unslop, etc.)
│   ├── unslop/              # AI writing & pattern removal
│   ├── yagni/               # Zero-overhead simplicity enforcement
│   ├── spec-driven-development/
│   ├── test-driven-development/
│   └── ...
├── configs/
│   ├── pi/                  # Pi settings & installed package registry
│   ├── omp/                 # OMP models, compaction order, and statusLine tuning
│   ├── opencode/            # OpenCode provider & agent configurations
│   ├── codex/               # Codex configurations & trusted projects
│   └── mcp/                 # Canonical MCP server manifests (Playwright, etc.)
└── scripts/
    └── sync-skills.sh       # One-shot symlinker & synchronization script
```

---

## 3. Quickstart & Environment Reproduction

On any new or existing machine:

```bash
# 1. Clone DevForge
git clone https://github.com/MSC72m/DevForge.git ~/code/DevForge
cd ~/code/DevForge

# 2. Run sync script
./scripts/sync-skills.sh
```

This ensures:
1. `~/.agents/skills/` receives all skills tracked in the repository.
2. `pi`, `omp`, `claude`, `opencode`, and `codex` are symlinked to `~/.agents/skills/`.
3. MCP configurations (`Playwright`, etc.) are linked into `pi` and `omp`.

---

## 4. Key Rules for Agents Adding Skills

When an AI agent creates or upgrades a skill:
1. **Always edit in `~/.agents/skills/<skill-name>/SKILL.md`** (or the target symlinked directory). Never break the symlink with a direct directory overwrite.
2. Keep the skill focused, adhering to the `yagni` and `unslop` guidelines.
3. Commit and push the changes back to `DevForge` so other devices stay in sync:
   ```bash
   cd ~/code/DevForge
   cp -R ~/.agents/skills/* ./skills/
   git commit -am "feat: add/update skill <skill-name>"
   git push origin main
   ```
