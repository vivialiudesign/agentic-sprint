# Agentic Sprint

A structured 5-phase multi-agent design sprint skill for Claude.
Not a faster design sprint — a decision system for AI-native design work.

## Install

See [INSTALL.md](INSTALL.md) for the full setup guide, including the optional
Mobbin MCP, Google Workspace MCP, and the recommended design skill stack.

**Claude Code (personal)**
```bash
unzip agentic-sprint.skill -d ~/.claude/skills/
```

**Claude Code (project)**
```bash
unzip agentic-sprint.skill -d .claude/skills/
```

**Cursor**
```bash
unzip agentic-sprint.skill -d ~/.cursor/skills/
```

**claude.ai**
Settings → Customize → Skills → upload `agentic-sprint.skill`

## Trigger phrases
- "let's run an agentic sprint"
- "agentic sprint on [problem]"
- "run a sprint"

## Phases
1. Define — problem sensemaking + principles + success metrics
2. Discover — agent research + competitive analysis + affinity mapping
3. Diverge — 16 ideas + mid-fidelity wireframes + agent voting
4. Converge — group solution + story test + storyboard-first, Mobbin-first design
5. Build — deck + hi-fi screens + build brief + quality score

## What's inside

- `SKILL.md` — the full sprint system (facilitator, agent tiers, 5 phases, timebox modes)
- `INSTALL.md` — one-time setup guide
- `references/agent-prompts.md` — reasoning patterns for all agents
- `references/convergence-guide.md` — scoring and recommendation formats
- `references/writing-guide.md` — content principles applied at every phase
- `agentic-sprint.skill` — the packaged skill, ready to upload or unzip
