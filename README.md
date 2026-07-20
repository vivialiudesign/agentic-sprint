# Agentic Sprint

Agentic Sprint is an AI-native workflow that uses multiple specialized agents to automate product development activities and help teams make better decisions. It synthesizes context, brings cross-functional perspectives into the process, explores solution spaces at scale, and automatically captures decision-ready artifacts — so teams can focus on deciding what is worth building.

If this resonates, a ⭐ on GitHub goes a long way — it helps others discover it.

---

## How to install

One command:

```bash
unzip agentic-sprint.skill -d ~/.claude/skills/
```

Or clone from this repo to get updates automatically:

```bash
git clone https://github.com/vivialiudesign/agentic-sprint \
  ~/.claude/skills/agentic-sprint
```

Restart Claude Code or Cursor. That's it.

> **Using Cursor?** Cursor (2.4+) reads the same Agent Skills format and auto-loads `~/.claude/skills/`, so the command above already works. To keep it in Cursor's own directory instead, target `~/.cursor/skills/`:
> ```bash
> unzip agentic-sprint.skill -d ~/.cursor/skills/
> # or, for updates:  git clone https://github.com/vivialiudesign/agentic-sprint ~/.cursor/skills/agentic-sprint
> ```
> Then invoke `/agentic-sprint` in Agent chat.


**Recommended:** add these MCPs so the sprint can read your Google Docs and push to Figma natively:

```bash
# Google Workspace — read PRDs, decks, research docs directly
# Figma MCP — push final screens to Figma
```

See [INSTALL.md](INSTALL.md) for the full setup guide.

---

## How to start a sprint

Type `/agentic-sprint` in Claude Code or Cursor, or just describe what you're working on:

```
Run a sprint on [problem]
Help me explore this from the user, business, and data perspective
I need to explore this before the XFN review on Thursday
```

The Facilitator asks two questions (project type + timebox) and begins.

---

## How it works

Five phases. Humans and agents each do what they're best at.

| Phase | Name | Who leads | What happens |
|---|---|---|---|
| 1 | Define | Human | Sharpen the problem · set principles · confirm agent roster |
| 2 | Discover | Agents | Gather insights with sources cited · generate HMWs · prioritize opportunities |
| 3 | Diverge | Agents | 8 ideas × 2 rounds, wireframed and voted on · top ideas emerge |
| 4 | Converge | Agents as a team | One group solution · story test · connected flow · final human decision |
| 5 | Build | Agents | Sprint Recap Deck · Key Screens · Build Brief · Executive Brief |

Decision points (DP1–DP6) require explicit human approval at every stage. Agents never resolve high-stakes calls silently.

**Live review page** — at the start of every sprint, a `sprint-review.html` opens in your browser and auto-refreshes every 30 seconds. Every phase output appears there in real time. Share-screen friendly for stakeholder walkthroughs.


## Human vs. agent roles

| Humans | Agents |
|---|---|
| Frame the problem | Gather and synthesize insights |
| Define principles and evaluation standards | Generate ideas at scale |
| Design the decision system | Explore multiple directions simultaneously |
| Navigate ambiguity and trade-offs | Evaluate concepts against principles |
| Make final decisions | Critique and refine solutions |

Agents amplify exploration. Humans own judgment.

<img width="1536" height="1024" alt="ChatGPT Image Jun 13, 2026, 11_30_08 PM" src="https://github.com/user-attachments/assets/910a24af-7a6d-4bf3-b985-fc344e03a1dd" />

---

## What problems it solves

**"I need to explore this problem but don't have time to run a full sprint."**
→ 1-hour mode runs all 5 phases. You get a Build Brief, key screens, and a decision log before your next meeting.

**"I'm stuck in my own perspective."**
→ Five agents each bring a different lens. The Data Agent surfaces the quantitative signal your intuition missed. The System Agent flags the architecture constraint before you fall in love with an idea.

**"I need XFN alignment before I can move forward."**
→ XFN Alignment mode maps conflicting stakeholder mental models first. Principles become the negotiated output — not just the designer's preferences.

**"I have a PRD — I need a design direction, not more process."**
→ Drop the PRD link into the sprint. The Facilitator reads it, routes signal to each agent, and you're in Phase 2 in under 5 minutes.

**"I need to show my work to leadership."**
→ Phase 5 produces a Sprint Recap Deck, Executive Brief, and connected key screens — ready to share, no formatting required.

---

## Who runs alongside you

**Tier 1 — Always active**

| Agent | What they bring |
|---|---|
| 🧑‍💻 User Agent | Pain points, mental models, behavioral research |
| 💼 Business Agent | Value, strategy, revenue, roadmap fit |
| 📊 Data Agent | Funnels, retention, A/B signal, quantitative evidence |
| 🏗️ System Agent | Architecture, tech debt, feasibility, consistency |
| 🎨 Design Agent | Craft, distinctiveness, design system, interaction quality |

**Tier 2 — Activated when needed**

| Agent | When to bring them in |
|---|---|
| ✍️ Content Agent | Auto-activates whenever wireframes are generated — writes all copy, no placeholders |
| 📣 Marketing Agent | Launch, positioning, go-to-market |
| ⚖️ Legal Agent | Privacy, compliance, regulated industries |
| 🎧 Customer Success Agent | Post-launch, churn, field signal |
| 💰 Finance Agent | Build vs. buy, pricing, margin |
| 🎯 Executive Agent | Strategic pivots, board narrative, vision alignment |
| 🔬 Quality Agent | Reliability-critical features, edge cases |

---

## What it produces

By the end of Phase 5, you have everything you need to move from exploration to execution:

- **Sprint Recap Deck** — the story of how you got to the decision, for stakeholders who weren't in the room
- **Key Screens + Flow** — connected mid/hi-fi screens annotated and ready for handoff
- **Storyboard** — the user story visualized as a sequential scene grid
- **Build Brief** — scope in/out, success metrics, technical starting point, next action
- **Executive Brief** — vision alignment, strategic fit, resource ask, risk — ready for any exec conversation
- **Decision Log** — a record of every DP: what was decided and what was ruled out

---

## Sprint modes

| Mode | Time | What you get |
|---|---|---|
| 1 hour | ~60 min | All 5 phases compressed · 4 ideas · wireframes · key screens · Build Brief |
| 1 day | ~4–6 hrs | Full depth · both ideation rounds · deck · all outputs |
| 3 days | Multiple sessions | Maximum research · 8 ideas × 2 rounds · full context pull · mockups throughout |
| No limit | Your pace | Everything, as deep as you want |

---

## Why Agentic Sprint

Traditional design and product development processes require significant effort to gather context, align stakeholders, explore solutions, and document outcomes. Agentic Sprint automates much of that work by combining the strengths of multiple AI agents with human judgment.

**Automates context gathering.** Instead of manually searching through documents and briefing participants, Agentic Sprint gathers relevant context from your connected sources before exploration begins. Research, requirements, prior decisions, and institutional knowledge are surfaced automatically so teams can start with a shared understanding.

**Leverages multi-agent cross-functional thinking.** Specialized agents represent different perspectives — user, business, data, systems, design, and customer support. Each examines the problem through a unique lens, surfaces trade-offs, identifies knowledge gaps, and contributes insights that would typically require multiple stakeholder conversations.

**Scales exploration with AI.** Agentic Sprint uses AI where it is most effective: synthesizing large amounts of information, connecting insights across sources, and generating diverse solution directions. Because agents retain context throughout the workflow, they can explore broadly without requiring teams to repeatedly provide the same information.

**Converges around principles and decisions.** As ideas move through the sprint, agents evaluate them against the principles, constraints, and success criteria the team established. Every recommendation stays grounded in prior decisions and trade-offs — helping teams converge on a direction that is both intentional and traceable.

**Captures artifacts automatically.** Teams don't need to manually assemble deliverables after the sprint. Insights, decisions, rationale, flows, wireframes, and recommendations are captured throughout and automatically organized into outputs tailored for different audiences.

---

## Skills it uses

**Auto-invoked:**

| Skill | When | What it does |
|---|---|---|
| `/frontend-design:frontend-design` | Phase 3, 4, 5 | Visual quality and craft at every fidelity level |
| Content Agent (built-in) | All phases | Writes all wireframe and screen copy · refines sprint output language · no placeholder text — principles in `references/writing-guide.md` |

**Sources it pulls from:**

| Source | When | What it does |
|---|---|---|
| Google Docs / Slides | Any phase | Reads PRDs, research docs, strategy decks you drop into the sprint |
| Mobbin | Phase 3 & 4 | Real-world screen references before wireframing |
| Figma (via MCP) | Phase 5 | Pushes final screens for design handoff |

**Optional — activate when you need them:**

| Skill | When |
|---|---|
| `/figma-use` | Pushing screens to Figma |
| `/figma-generate-design` | Generating full Figma screens from sprint output |
| `Vercel React Best Practices` | Building screens that will ship as React code |
| `UI/UX Pro Max` | Deeper interaction states, edge cases, accessibility |

---

## Repo contents

```
SKILL.md                          — Full skill definition
INSTALL.md                        — One-time setup guide
agentic-sprint.skill              — Bundled install file
references/
  agent-prompts.md                — Reasoning patterns for all 12 agents
  convergence-guide.md            — HMW scoring, idea evaluation, recommendation format
  writing-guide.md                — Writing principles applied to every sprint output
```

---

## Stay current

```bash
cd ~/.claude/skills/agentic-sprint && git pull
```

---

*Built by Vivia Liu · 2026*
