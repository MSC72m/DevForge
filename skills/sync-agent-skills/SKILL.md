---
name: sync-agent-skills
description: Guide and procedure for future AI agents to synchronize, add, or update skills and MCP configurations across Pi, OMP, Claude Code, OpenCode, and Codex using DevForge.
---

# Sync Agent Skills Guide

Use this skill whenever you need to add, update, debug, or verify agent skills and harness configurations across `pi`, `omp`, `claude`, `opencode`, and `codex`.

## Architecture Invariant

`~/.agents/skills/` is the single source of truth:
- `~/.pi/agent/skills` -> `~/.agents/skills`
- `~/.omp/agent/skills` -> `~/.agents/skills`
- `~/.claude/skills` -> `~/.agents/skills`
- `~/.config/opencode/skills` -> `~/.agents/skills`
- `~/.codex/skills/*` -> individual symlinks to `~/.agents/skills/*`

The git repository backing this setup is at `/Users/msc8/code/DevForge` (remote: `https://github.com/MSC72m/DevForge.git`).

## Adding a New Skill

1. **Create Skill Directory**:
   Always create it inside `~/.agents/skills/<skill-name>/SKILL.md`:
   ```bash
   mkdir -p ~/.agents/skills/<skill-name>
   ```

2. **Include Valid Frontmatter**:
   ```markdown
   ---
   name: <skill-name>
   description: <crisp, single-sentence summary of what the skill does and when to invoke it>
   ---

   # Skill Name
   ...
   ```

3. **Check Symlinks & Refresh**:
   Verify the symlinks exist for `pi`, `omp`, etc.
   In `Codex`, if a new folder was created, add the symlink:
   ```bash
   ln -sfn ~/.agents/skills/<skill-name> ~/.codex/skills/<skill-name>
   ```

4. **Sync Back to DevForge**:
   ```bash
   cp -R ~/.agents/skills/<skill-name> ~/code/DevForge/skills/
   cd ~/code/DevForge
   git add skills/<skill-name>
   git commit -m "feat(skills): add <skill-name>"
   git push origin main
   ```

## Rules

- Never replace `~/.pi/agent/skills` or `~/.omp/agent/skills` with a standalone directory; always keep them symlinked to `~/.agents/skills`.
- Follow `yagni` and `unslop` principles for all documentation and code.
