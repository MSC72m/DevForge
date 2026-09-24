# DevForge

Unified environment, skills vault, configuration store, and reproduction harness for AI coding agents (`omp`, `pi`, `Claude Code`, `OpenCode`, and `Codex`).

---

## 1. Upstream Respect & Author Licensing

DevForge tracks and respects upstream package provenance:
- **Upstream Open Skills**: Managed via the ecosystem package manager (`npx skills`). Installed skills are tracked with cryptographic folder hashes, original source URLs (e.g. `mattpocock/skills`, `vercel-labs/skills`, `addyosmani/agent-skills`), and upstream commit revisions inside `skills-lock.json`.
- **License Preservation**: Each skill retains its original license, frontmatter, author credit, and attribution (`CREDITS.md`, `README.md`, `metadata.json`).
- **One-Command Upstream Updates**: Run `./scripts/update-skills.sh` to pull latest changes from upstream GitHub repositories without losing custom configurations or symlinks.

---

## 2. Architecture & Symlink Layout

Different AI coding harnesses store configuration and skills in different filesystem paths:
- **OMP**: `~/.omp/agent/skills/` & `~/.omp/agent/mcp.json`
- **Pi**: `~/.pi/agent/skills/` & `~/.pi/agent/settings.json`
- **Claude Code**: `~/.claude/skills/`
- **OpenCode**: `~/.config/opencode/skills/` & `opencode.json`
- **Codex**: `~/.codex/skills/` & `config.toml`

### Single Source of Truth
DevForge centralizes all skills under `~/.agents/skills/`. All agent harnesses point directly to this central vault via managed symlinks. A skill added or tuned once is immediately accessible across all environments.

---

## 3. Directory Layout

```text
DevForge/
├── skills/                  # Master skill vault (76+ skills: SDD, TDD, YAGNI, unslop, etc.)
│   ├── unslop/              # AI writing & pattern removal
│   ├── yagni/               # Zero-overhead simplicity enforcement
│   ├── spec-driven-development/
│   ├── test-driven-development/
│   └── ...
├── skills-lock.json         # Cryptographic provenance & upstream Git origins
├── configs/
│   ├── pi/                  # Pi settings & installed package registry
│   ├── omp/                 # OMP models, compaction order, and statusLine tuning
│   ├── opencode/            # OpenCode provider & agent configurations
│   ├── codex/               # Codex configurations & trusted projects
│   └── mcp/                 # Canonical MCP server manifests (Playwright, etc.)
└── scripts/
    ├── sync-skills.sh       # One-shot symlinker & environment reproduction script
    └── update-skills.sh     # Upstream update runner (via npx skills update)
```

---

## 4. Workflows

### Reproduce Environment on a New Machine
```bash
git clone https://github.com/MSC72m/DevForge.git ~/code/DevForge
cd ~/code/DevForge
./scripts/sync-skills.sh
```

### Pull Upstream Updates from Original Authors
```bash
cd ~/code/DevForge
./scripts/update-skills.sh
git commit -am "chore(skills): sync upstream updates"
git push origin main
```

### Adding New Skills
1. For open ecosystem skills:
   ```bash
   npx skills add <github-owner/repo> -g
   ./scripts/update-skills.sh
   ```
2. For custom authored skills:
   - Create `~/.agents/skills/<skill-name>/SKILL.md`.
   - Run `./scripts/update-skills.sh` to mirror into DevForge and re-link all harnesses.
