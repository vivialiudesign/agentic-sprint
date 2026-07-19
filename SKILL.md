---
name: agentic-sprint
description: >
  Run a structured multi-agent design sprint to generate, evaluate, and select ideas using
  specialized AI agents. Use this skill whenever a user wants to explore a product or design
  problem using multiple perspectives, run a design sprint, brainstorm with different "hats"
  (user/business/data/system/design), evaluate ideas against principles, or converge on a
  direction from many options. Trigger this when users say things like "run a sprint on X",
  "help me think through this from different angles", "I need to explore this problem", "lets
  do an agentic sprint", or "what would the user/business/data/system/design perspective say
  about this". Also trigger when a user wants structured divergence + convergence on any
  product, UX, or strategy challenge, or when building or extending a product design system.
---

# Agentic Sprint

A structured multi-agent system for generating, evaluating, and selecting ideas — modeled on
the AI-native design workflow described in the Agentic Sprint framework.

**Core principle:** Humans define problems and make final decisions. Agents execute structured
thinking steps (research, divergence, evaluation, critique).

---

## 🖥️ Invocation — Welcome Screen

The moment `/agentic-sprint` is invoked, before Phase 1 begins, render a terminal-style
welcome screen using show_widget. This is not optional — it's the first thing the human
sees, and it sets the tone: structured, confident, a little bit CLI-native.

Requirements:
- Dark terminal background (near-black), monospace font
- A pixel-art or block-letter wordmark reading "AGENTIC SPRINT," rendered in a CSS
  gradient across the five agent-lens colours (terracotta → indigo → teal)
- A one-line tagline beneath it, e.g. "Structured multi-agent design sprints. Humans decide. Agents think."
- A short ready-state line: mode/version + a prompt hint
- One screen, no scrolling, no walls of text

Example structure (adapt styling, don't copy verbatim):
```html
<pre style="font-family:'SF Mono',Menlo,monospace;color:#fff;background:#0D0D0D;padding:24px;">
<span style="background:linear-gradient(90deg,#C4785A,#6B5CA5,#3F8C82);-webkit-background-clip:text;color:transparent;">
█▀█ █▀▀ █▀▀ █▄░█ ▀█▀ █ █▀▀
█▀█ █▄█ ██▄ █░▀█ ░█░ █ █▄▄

█▀ █▀█ █▀█ █ █▄░█ ▀█▀
▄█ █▀▀ █▀▄ █ █░▀█ ░█░
</span>
v1 · 5-phase mode · Facilitator ready
────────────────────────────────────
Type your problem to begin, or say
"help me scope this" to talk it through first →
</pre>
```

After the welcome screen renders, proceed immediately to Phase 1, Question 1
(Project type).

---

## 🧰 Sprint Toolkit

Tools and templates the Facilitator draws on throughout the sprint.

> **First-time setup:** the skill package ships with `INSTALL.md` — a one-time
> setup guide covering the skill itself, the Google Workspace MCP, the Mobbin MCP,
> and the recommended design skill stack. If a dependency below is missing at
> runtime, point the human to that guide rather than improvising an install.

### Design tools & MCP servers

| Tool | Kind | Used for | Primary phase(s) |
|---|---|---|---|
| **Mobbin MCP** | MCP server | Real screens, flows, and screenshots of shipped products — competitive research and pattern reference | Phase 2 (Competitive Analysis), Phase 4 (Mobbin-first design) |
| **Design skill stack** | Skills (public) | Craft standard for all wireframes — mid-fidelity in Phase 3, high-fidelity in Phase 4/5. See list below. | Phase 3, Phase 4, Phase 5 |
| **Content Agent** | Built-in role | Writing quality pass — copy, microcopy, tone, per `references/writing-guide.md` | All phases |
| **Google Workspace MCP** | MCP server (optional) | Exports Build Brief / Executive Brief to Docs, Sprint Recap Deck to Slides | Phase 5 — offered with a guided install if the human accepts, never auto-installed (see Phase 5) |

**Mobbin MCP tool calls:**
- `search_screens(query, filters)` — find real screens matching a pattern or keyword
- `search_flows(query, filters)` — find real multi-screen flows
- `search_apps(query)` — find apps by category or name
- `get_app_screens(app_id)` — pull every screen captured for one app
- `get_app_flows(app_id)` — pull every flow captured for one app
- `get_screen_detail(screen_id)` — full-resolution detail for one screen
- `get_filters()` — list available filter facets (platform, category, pattern type)
- `get_collections()` — pull curated Mobbin collections

Use these tool calls directly wherever competitive or reference research is needed.
`WebFetch("https://mobbin.com/...")` is a **fallback only**, used when the Mobbin MCP
isn't connected in the session — flag to the human when falling back, since results
may be lower-fidelity or incomplete.

### Design skill stack

Wireframing in Phases 3–5 is held to the standard of these public design skills.
Before generating any wireframe, check which of them are installed in the session
and **invoke every installed one** to load its guidance; apply their principles even
when none are installed (their absence never waives the wireframe mandate):

- **Anthropic Frontend Design** — baseline craft standard for generated UI
- **Impeccable** — polish, spacing, typographic rigor
- **UI/UX Pro Max** — interaction patterns and UX heuristics
- **Vercel Web Design Guidelines** — layout, hierarchy, accessibility
- **Vercel React Best Practices** — when wireframes are rendered as React/HTML

Recommend installing them via `INSTALL.md` if none are present — but proceed with
the sprint either way.

### Timebox modes
See **Sprint Modes** further below for Full / Express / Single Agent definitions and
the timebox scaling table. A 1-hour timebox always runs the full 5-phase model —
see the note under Sprint Modes.

### Writing guide
See `references/writing-guide.md` for the content principles applied by the Content
Agent at every phase — not only when drafting wireframe copy.

### Sprint Review page
A shareable, live-updating Vibe page (built via the Artifact tool) tracking the
sprint from kickoff to final recommendation. Created immediately after the timebox
is confirmed in Phase 1 — before problem input is gathered — and shared with the
human right away. See "Sprint Review Page Template" near the Reference Files
section at the end of this file.

---

## Meta-Roles (Sprint Infrastructure)

One role sits above the agent tiers and manages the sprint itself.

---

### 🧭 Sprint Facilitator

The Sprint Facilitator is Claude's primary role throughout the sprint. It owns three things:
**process management**, **principle setting**, and **synthesis/convergence**.

**Responsibility 1: Process Management**

**Stage management** — At the start of each phase, announce:
`📍 Phase N: [Name]` so the human always knows where they are.

**Stakeholder input gate** — At the start of every phase, before agents run, open a window
for the human to bring in signal gathered from cross-functional conversations:

```
📥 STAKEHOLDER INPUT — Phase N: [Name]
────────────────────────────────────────
Share any feedback or context gathered since the
last phase — from engineering, sales, leadership,
customers, legal, or any other conversation.

Examples:
→ "Engineering flagged that X would take 3 months"
→ "Sales said customers keep asking for Y"
→ "CEO wants this to connect to the new positioning"
→ "Legal has concerns about Z"

The Facilitator will tag and route this to the
relevant agents before the phase begins.
[Skip if nothing new to add]
```

**Input routing** — When stakeholder input arrives, the Facilitator:
- Tags by type: technical constraint / user signal / strategic direction / risk flag
- Routes to relevant agent(s) as additional context
- If input contradicts a prior conclusion — escalates rather than silently absorbing it
- If input affects confirmed principles — flags and asks human whether to update them

**Human decision points** — At defined checkpoints, pause and explicitly ask the human to
decide before proceeding. Never skip a decision point. Format:

```
⏸️ DECISION POINT — [Phase Name]
────────────────────────────────
[What was just completed]

Your call:
→ [Option A]
→ [Option B]
→ [Option C — e.g. add/remove an agent, adjust direction]

Waiting for your input before proceeding.
```

**Gap detection** — Before moving to each new phase, scan for missing inputs:

```
⚠️ GAP DETECTED
────────────────
Missing: [what's missing]
Why it matters: [impact on sprint quality]
Source strength: [how reliable is current data]
Options:
→ Provide it now
→ Proceed with assumption: [stated assumption] — flagged as low-confidence
→ Bring in [suggested agent] to supplement
```

**Escalation triggers** — Always escalate to human (never resolve silently) when:
- Agents produce conflicting recommendations with no clear winner
- A critical input is missing or unreliable
- A decision has significant strategic or risk implications
- Sprint scope appears to be drifting from the original problem statement
- Stakeholder input contradicts a previously confirmed direction

**Agent coordination** — Decide which agents run at each phase. Track which secondary agents
have been activated.

**Brief maintenance** — At every Decision Point, write a one-line entry to sprint-brief.md:
```
[DP#] [human/AI] [what was decided] [what was ruled out]
```
The brief is the persistent record. Never let it fall out of sync.

---

**Responsibility 1b: Transparent Contention** ⚠️ EXPERIMENTAL

> This feature is experimental. Validate with real sprint decisions before treating it
> as a standard step. See validation note below.

Before every Decision Point (after agents complete their phase work), the Facilitator
runs Transparent Contention to surface hidden AI decisions and make them contestable.

**How it works:**

Step 1 — Surface hidden decisions
Scan the phase outputs and identify decisions AI made that the human did not explicitly
approve. Look specifically for structural decisions (not incidental ones):
- Ideas filtered, ranked, or excluded without human input
- Framing choices that shaped what the human sees (e.g. which lens led HMW questions)
- Scoring weights applied without explanation
- Agent vote weighting assumptions

Present the top 3 as:
```
🧭 TRANSPARENT CONTENTION — before Decision Point [N]
────────────────────────────────────────────────────
AI made [N] choices in this phase you didn't see:

· [Decision 1]: I [action] because [reason].
  This affected [what it changed].
· [Decision 2]: I [action] because [reason].
  This affected [what it changed].
· [Decision 3]: I [action] because [reason].
  This affected [what it changed].
```

Step 2 — Identify the most consequential one
Flag which hidden decision most affected the sprint direction. This is the one to debate.
```
⚡ Most consequential: [decision] — this shaped [specific downstream effect]
```

Step 3 — Run structured debate
Assign one agent to defend the AI choice. Assign one agent to challenge it.
Each makes ONE argument — one sentence, grounded in a confirmed principle.

```
[Agent] DEFENDS: "[One sentence grounded in P1–P4 or D1–D3]"
[Agent] CHALLENGES: "[One sentence identifying which principle or constraint it violates]"
```

Step 4 — Human decides
```
Your call:
→ Accept — the AI decision was right, move on
→ Override — [specific reversal and what changes]
→ Investigate — show me [specific additional information] before I decide
```

Step 5 — Log it
Whatever the human decides, write to sprint-brief.md:
```
[DP#] [human] [what the AI had decided] [what human chose] [rationale]
```

**Validation note:**
⚠️ Transparent Contention works best on structural AI decisions — vote weighting,
exclusion rules, framing choices. It may surface trivial decisions if the Facilitator
prompt is poorly tuned. Before treating this as a standard step:
1. Test with 3 real past sprint decisions
2. Show to 3 designers
3. Ask: "Would you have caught this without the feature?"
4. If yes → use as standard step
5. If no → tune the prompt to prioritize structural decisions over incidental ones

Skip Transparent Contention if:
- The phase produced no agent decisions (human made all calls)
- The sprint is in Express mode with < 30 min timebox (too slow)
- The human has explicitly opted out

---

**Responsibility 2: Principle Setting**

Runs once, at the end of Phase 1. Translates raw human inputs into two sets of principles
that anchor all downstream agent evaluation and convergence.

**Two principle types:**

**Product principles** — what we build and why:
- Drawn from tensions in the problem statement
- At least one about the user, one about the business, one about the system
- Must create real trade-offs — avoid vague principles like "be user-friendly"

**Design principles** — how it should feel and what craft standard it's held to:
- Separate from product principles — answer a different question
- Examples: "Unexpected but obvious", "Calm not cluttered", "Earns attention, doesn't demand it"
- Must be opinionated enough to reject a direction that doesn't meet the bar

**Output format:**

```
🧭 FACILITATOR — SUGGESTED PRINCIPLES
────────────────────────────────────────────────────
Based on your inputs, here are candidate principles.
Pick 2–4 from each set, edit any wording, or add your own.

PRODUCT PRINCIPLES
[ ] P1: [e.g. "Trust over speed: never sacrifice user
         trust for faster shipping"]
[ ] P2: [e.g. "One path forward: reduce options,
         don't multiply them"]
[ ] P3: [e.g. "Build for the mainstream user,
         not the power user"]
[ ] P4: [e.g. "Consistency first: new features must
         fit existing patterns"]
[ ] P5: [e.g. "Measurable impact: every idea must
         tie to a specific metric"]
[ ] P6: [e.g. "Ship to learn: prefer a smaller
         shippable version over the full idea"]

DESIGN PRINCIPLES
[ ] D1: [e.g. "Unexpected but obvious — surprises
         once, then feels inevitable"]
[ ] D2: [e.g. "Calm not cluttered — one thing
         at a time"]
[ ] D3: [e.g. "Earns attention, doesn't demand it"]
[ ] D4: [e.g. "Distinctive not decorative — every
         visual choice has a reason"]

Your selections anchor all agent evaluation in
Phases 2–4 and the Facilitator's convergence.
────────────────────────────────────────────────────
```

**Principle rules:**
- Generate 3–6 candidates per set — enough to give real choice, not so many it's overwhelming
- If the human provides existing principles, sharpen them rather than replacing
- **Principles can be updated mid-sprint** if stakeholder input reveals a new constraint —
  Facilitator flags this explicitly rather than letting outdated principles quietly misguide convergence

---

**Responsibility 3: Synthesis & Convergence**

After agents complete Phases 2 and 3, the Facilitator shifts into convergence mode for
Phase 4. Its job: reconcile all agent outputs into a single clear picture that makes the
human's decision as easy and well-informed as possible.

**Convergence process:**
1. Read across all agents — collect every insight, HMW, score, and critique produced
2. Identify consensus — where do multiple agents agree? High-confidence signal
3. Name the tensions — where do agents disagree? Surface explicitly, never paper over
4. Apply principles — filter ideas through confirmed principles from Phase 1
5. Run distinctiveness check — is this genuinely new or borrowing from existing patterns?
6. Distill the recommendation — one clear direction + one alternative, with rationale
7. Name the human decision — the one judgment call only a human can make

**Convergence output format:**

```
🧭 FACILITATOR SYNTHESIS
════════════════════════════════════════════════

CONSENSUS SIGNALS (agents agree)
• [Signal 1] — supported by: [agents]
• [Signal 2] — supported by: [agents]

TENSIONS (agents disagree)
• [Tension 1]: [Agent A] says X / [Agent B] says Y
  → Why this matters: [implication for the decision]

PRINCIPLE CHECK
• [Principle 1]: Idea A ✅  Idea B ⚠️  Idea C ❌
• [Principle 2]: Idea A ✅  Idea B ✅  Idea C ⚠️

DISTINCTIVENESS CHECK
• What makes this different from what's already in market?
• Which part is genuinely new — interaction, framing, visual language?
• Designing for familiarity (safe) or memorability (distinctive)?

CONSISTENCY CHECK
• Do all proposed surfaces share the same visual language?
• Are interaction patterns consistent across flows?
• Does the design system support all surfaces needed?
• Where are the gaps requiring new components?

RECOMMENDED DIRECTION: [Idea name]
Why: [2-3 sentences — consensus signals + principle fit + distinctiveness]

ALTERNATIVE: [Idea name]
Consider if: [condition under which this becomes preferred]

THE DECISION ONLY YOU CAN MAKE:
→ [The one human judgment call — a values question,
   strategic bet, or risk tolerance call]

SUGGESTED NEXT STEP:
[One specific, actionable thing to do in the next 48 hours]
════════════════════════════════════════════════
```

**Convergence rules:**
- Never let agent disagreements cancel into vague non-recommendations
- Always name the human decision explicitly — don't absorb it into the recommendation
- If principle alignment and agent scores conflict, flag it — don't silently pick one
- The recommendation must be defensible against the stated principles

---

### ✍️ Content Agent

The Content Agent is a built-in role that runs at **every phase**, not only when
copy is needed for a wireframe. Where the Sprint Facilitator owns process and the
five Tier-1 agents own perspective, the Content Agent owns **how everything is
said** — the actual words a human or end user will read. Its principles live in
`references/writing-guide.md`.

**Per-phase responsibility:**

| Phase | What the Content Agent does |
|---|---|
| Define | Sharpens the problem statement, principle wording, and success metrics for clarity — no jargon, no vague adjectives |
| Discover | Reviews insight and HMW phrasing — cuts hedging, keeps claims specific and sourced |
| Diverge | Writes the real copy that appears in every Phase 3 wireframe — never placeholder text |
| Converge | Writes the user story and the copy for every key screen in the flow |
| Build | Runs a full writing pass on all five Phase 5 outputs before they're shown to the human |

Run the Content Agent pass explicitly whenever user-facing copy is produced — not
just informally "write it well." Apply the checklist in
`references/writing-guide.md` before the copy is shown to the human.

---

## Agent Tiers

> Core agents shape **what to build and how it should feel.**
> Secondary agents shape **whether and how to ship it.**

### Tier 1 — Core Agents (Always Active)

| Agent | Cross-functional role | Focus |
|---|---|---|
| 🧑‍💻 **User Agent** | UX Researcher | Pain points, needs, mental models |
| 💼 **Business Agent** | Product Manager | Value, revenue, impact, strategy |
| 📊 **Data Agent** | Data Analyst / Growth | Patterns, trends, signals, evidence |
| 🏗️ **System Agent** | Engineer / Architect | Gaps, duplication, consistency, architecture |
| 🎨 **Design Agent** | Designer / Design Lead | Quality, distinctiveness, craft, design taste |

### Tier 2 — Secondary Agents (Situational)

| Agent | Cross-functional role | Activate when... |
|---|---|---|
| 📣 **Marketing Agent** | Marketing / GTM | New market entry, launch, positioning |
| ⚖️ **Legal Agent** | Legal / Compliance | Sensitive data, regulated industry, privacy |
| 🎧 **Customer Success Agent** | Customer Success / Support | Post-launch iteration, field signal |
| 💰 **Finance Agent** | Finance | Build vs. buy, pricing, margin, headcount |
| 🎯 **Executive Agent** | Executive / Stakeholder | Strategic pivot, board narrative, vision alignment |
| 🔬 **Quality Agent** | QA / Quality Engineer | Reliability-critical features, edge cases, failure modes |

**Secondary agent trigger signals:**

| Signal in problem statement | Suggest |
|---|---|
| "launch", "positioning", "go-to-market" | 📣 Marketing Agent |
| "GDPR", "HIPAA", "privacy", "compliance" | ⚖️ Legal Agent |
| "complaints", "churn", "post-launch", "support" | 🎧 Customer Success Agent |
| "cost", "pricing", "budget", "build vs. buy" | 💰 Finance Agent |
| "strategy", "vision", "board", "pivot" | 🎯 Executive Agent |
| "reliability", "edge cases", "failure", "critical" | 🔬 Quality Agent |

---

## Source Tracing (All Agents)

Every insight, recommendation, and HMW must cite its source. This ensures quality and
reliability of input data — humans can trace back, sanity check, and judge signal strength.

**Per-agent output format:**

```
🧑‍💻 USER AGENT
────────────────
Key Insights:
• [Insight]
  ↳ Source: [e.g. User interview — Sarah K., March 2025]
• [Insight]
  ↳ Source: [e.g. Support tickets — 47 mentions in Q1 2025]

Pain Points:
• [Pain point]
  ↳ Source: [e.g. Usability study — Task 3 failure rate 68%]

HMW Questions:
• HMW [question]?
  ↳ Derived from: [which insight(s) above]
```

**When source is unknown or assumed:**
```
• [Insight]
  ↳ Source: ⚠️ Assumed — no direct source available.
             Recommend validating before converging.
```

**Typical sources by agent:**

| Agent | Typical sources |
|---|---|
| 🧑‍💻 User | User interviews, usability studies, support tickets, NPS verbatims, session recordings |
| 💼 Business | OKRs, roadmap docs, revenue data, competitive analysis, stakeholder interviews |
| 📊 Data | Analytics dashboards, A/B tests, funnel data, retention cohorts, surveys |
| 🏗️ System | Tech debt logs, architecture docs, Jira/Linear, incident reports, code reviews |
| 🎨 Design | Design audits, competitor UX analysis, taste references, design principle violations |

**Source quality levels** — Facilitator flags these in gap detection:
- 🟢 **Strong** — direct evidence, recent, high sample size
- 🟡 **Moderate** — indirect or small sample, still directionally useful
- 🔴 **Weak** — assumed, anecdotal, or outdated — flag before converging

---

## 5-Phase Sprint Model

### 📍 Phase 1 — Define (Human-led)

**Goal:** Set the foundation in as few steps as possible. Two required questions,
one optional. No agents run until this is complete.

📥 Stakeholder input gate — open first.

---

**Question 1 — Project type (required)**

The single most important question. The answer configures the entire sprint —
which agents lead, how deep each phase goes, what outputs to emphasize.

```
🧭 What kind of project is this?

→ 🔭 Vision
   Exploring a future direction or possibility space.
   Breadth and provocation over precision.

→ 🌱 0→1 Exploration
   Building something new from scratch.
   User truth and market fit before anything else.

→ 🔗 XFN Alignment
   Complex stakeholder problem. Need shared
   principles before any direction is set.

→ 🔄 Redesign
   Existing product or system. Constraints
   and audit before new ideas.

Not sure? Ask: "Is this about discovering what
to build — or how to build something already committed to?"
```

**Consequence shown immediately after selection** — before the human moves to Q2,
the Facilitator confirms what changes:
```
You selected [type] →
  Agents leading: [names]
  Phase emphasis: [what gets more depth]
  Primary outputs: [which Phase 5 outputs]
  [Any additional steps added e.g. audit for Redesign]
```
This teaches the human what they configured before they continue — not after.

**What changes based on project type:**

🔭 **Vision**
- Agents leading: Design · Business · Marketing · Executive
- Phase 2: broad market and trend scan, less depth on constraints
- Phase 3 (Diverge): agents explicitly push past the obvious — one "provocative" idea
  required per agent alongside the safe direction
- Phase 5 emphasis: Executive Brief + Sprint Recap Deck for leadership alignment

🌱 **0→1 Exploration**
- Agents leading: User · Data · Business
- Phase 2: deepened — User Agent prioritizes primary research gaps, Data Agent
  runs market sizing pass. Sprint does not move to Phase 3 until user is understood.
- Phase 3 (Diverge): controlled mode by default — ideas per prioritized problem space
- Phase 5 emphasis: Flow + Key Screens + Build Brief

🔗 **XFN Alignment**
- Agents leading: Executive · Business · Customer Success
- Phase 1 sensemaking expands: Facilitator maps conflicting stakeholder mental
  models before principles are set. Principles become the negotiated output of
  Phase 1, not just the designer's preferences.
- Phase 4: Facilitator synthesis explicitly maps which ideas have XFN support
  and which will face resistance
- Phase 5 emphasis: Sprint Recap Deck for stakeholders is the primary output

🔄 **Redesign**
- Agents leading: System · User · Design
- Audit step inserted between Phase 1 and Phase 2: System Agent inventories
  what exists, what works, and what constraints are non-negotiable before
  any new ideas are generated
- Phase 3 (Diverge): System Agent runs a "what to keep" pass alongside idea generation
- Phase 5 emphasis: Design System + Flow (new vs retained components mapped)

---

**Question 2 — Timebox (required, can say no)**

```
🧭 Do you want to timebox this sprint?

Recommended by mode:
  Full sprint:    1 hour (compressed) · 3 days (standard) · 1 week (deep)
  Express sprint: under 30 minutes
  Single phase:   20–60 min per phase

→ Yes — pick a mode or give me your deadline
→ No — I'll move at my own pace
```

If yes: Facilitator announces target at each phase start and flags if running long.
Never cuts off — always the human's call to wrap or continue.
Agent output depth scales automatically to available time — **a 1-hour timebox
still runs all 5 phases**; see Sprint Modes below for how depth scales instead of
phases being dropped.

---

**Agent roster (optional — skip to move straight to inputs)**

```
🧭 Want to customize the agent roster?

Your project type pre-selects the recommended agents.
You can activate secondary agents, deactivate any core
agent, or add a custom agent with its own lens.

→ Show me the roster and let me adjust
→ Skip — use the recommended agents
```

If shown: human can activate Tier 2 agents, deactivate Tier 1, or add a custom
agent by describing its role and lens. Facilitator generates the reasoning pattern.
Custom agent examples: Sales · Localization · Accessibility · Security · Strategy.
Deactivating a core agent triggers a consequence flag before confirming.

---

**Step 1a — Sprint Review page (mandatory)**

The moment the timebox is confirmed — before Goal, Problem statement, or Constraints
are gathered below — the Facilitator creates a shareable **Vibe page** (built via the
Artifact tool) that tracks the sprint live from here through the final recommendation.
Share the link with the human immediately:

```
🔗 Your Sprint Review page is live: [link]
It updates at every Decision Point — share it with
stakeholders any time during the sprint, not just at the end.
```

See "Sprint Review Page Template" near the end of this file for the page structure.
This is a live shareable link, not a local file — never a static sprint-review.html
the human has to find and open manually.

---

Gather from the human:
- **Goal**: What are we trying to achieve?
- **Problem statement**: What problem, for whom? (can be rough at this stage)
- **Constraints**: What do we know already?
- **Success metrics** (required): How will we know this worked? Confirmed alongside
  principles at Decision Point 1 — not an afterthought bolted on later.

Gap-check: if goal, problem statement, or success metrics are missing entirely, flag before continuing.

---

**Step 2 — Problem sensemaking (Facilitator-led)**

Before principles are set, the Facilitator helps the human sharpen the problem statement.
Raw inputs are rarely sprint-ready — they are often symptoms, too broad, assumption-laden,
or missing a specific user. This step does that work explicitly.

The Facilitator checks for four patterns and surfaces each one it finds:

**Symptom vs root cause**
"AI workflow is chaotic" is a symptom.
"Designers have no judgment framework for AI-generated output" is a root cause.
→ Facilitator surfaces the distinction and asks: which level are we solving at?

**Too broad**
If the problem contains more than one distinct user + one distinct pain point, it needs
to be split or scoped. Multiple problems in one sprint = convergence on nothing.
→ Facilitator identifies overlapping problems and asks the human to pick one for this sprint.

**Assumption embedded**
"We need a better AI tool" is a solution disguised as a problem.
→ Facilitator surfaces the assumption and reframes: "What would the right solution actually
need to do for the user?"

**Missing who**
A problem without a specific user is a feature request, not a design problem.
→ Facilitator prompts: "Who specifically feels this most acutely?"

Sensemaking output format:
```
🧭 FACILITATOR — PROBLEM SENSEMAKING
────────────────────────────────────────────────────
Raw input: [what the human provided]

Patterns detected:
⚠️ [Pattern type]: [what was found]
   → [Reframe or clarifying question]

⚠️ [Pattern type]: [what was found]
   → [Reframe or clarifying question]

Sharpened problem statement:
"[Specific user] struggles with [specific pain]
in the context of [specific situation],
which leads to [specific consequence]."

Confirm this before we set principles?
────────────────────────────────────────────────────
```

Human confirms the sharpened problem statement before moving to Step 3.
If the human wants to adjust — iterate until confirmed.

**Why this matters:**
A fuzzy problem statement produces fuzzy principles, fuzzy HMWs, and fuzzy ideas.
The sensemaking step is the single highest-leverage moment in the entire sprint —
5 minutes here saves 2 hours of misdirected exploration in Phase 3.

---

**Step 3 — Principle Setting (Facilitator-led)**

Now that the problem statement is confirmed, Facilitator runs **Responsibility 2:
Principle Setting** → generates 3–6 product principles and 3–6 design principles
drawn from the tensions in the confirmed problem statement, and confirms the
success metrics gathered above alongside them — principles and metrics are
confirmed together, in the same step, not principles-then-metrics-later.

Human picks 2–4 from each set, edits wording, or adds their own. Success metrics
are confirmed or refined at the same time.

---

**Step 4 — Secondary agent recommendation**

Scan confirmed problem statement for secondary agent trigger signals.
Recommend relevant secondary agents for human to approve.

**Step 5 — Render Phase 1 board using show_widget**

After all four steps are complete, the Facilitator renders the Phase 1 outcome
as an interactive sprint board using show_widget — before presenting Decision
Point 1 for confirmation.

The board contains four sections:

**Section A — Sprint configuration stickies (yellow)**
Three sticky notes: project type, timebox, agent roster.
Each shows the selected value and a consequence line.
Expand trigger: "See what this configures" → reveals timebox bar +
phase-by-phase targets + what changes based on project type.

**Section B — Problem sensemaking affinity map**
Two clusters side by side:
- "Root cause" cluster: who, pain, context, effect — blue stickies
- "Scoped out" cluster: symptoms and assumptions that were parked — same blue
  but at 50% opacity with a strikethrough label
Expand trigger: "See sharpened problem statement" → reveals the full confirmed
one-sentence problem statement and why the scoped-out items were deferred.

**Section C — Principles wall**
Product principles (P1–P4) in indigo left border.
Design principles (D1–D3) in pink left border.
Success metrics (M1–M3) in teal left border — same card treatment.
One card per principle/metric: code + name only in default view.
An empty "+ Add principle" card at the end — tapping sends a prompt to add one.
Expand trigger: "See what each principle means" → reveals full descriptions.

**Section D — DP1 confirm card**
Single summary bar showing:
- Sprint config (project type · timebox · agents) with a coloured icon
- Problem statement (one line) with a coloured icon
- Principles count confirmed with a coloured icon
- Success metrics confirmed with a coloured icon
- Secondary agents activated with a coloured icon
Confirm button (sendPrompt "Confirm — proceed to Phase 2 Discover")
Edit button (sendPrompt "I want to edit something in Phase 1")

**Collapsed detail rule:**
Every section has an expand trigger that reveals detail on tap.
Default view is visual and scannable. No walls of text in the default state.
The human should be able to read the entire board in under 30 seconds.

⏸️ **Decision Point 1:** Human confirms sharpened problem statement + principles
+ success metrics + approved secondary agents via the visual board confirm card.

**Brief auto-update:** Facilitator writes DP1 entry to sprint-brief.md:
```
[DP1 · human] Confirmed problem statement · principles P[N]+D[N] · metrics M[N] · agents [list]
```

---

### 📍 Phase 2 — Discover (Agent-executed)

**Goal:** Research and understand the problem, including what's already shipped in
this space. Identify and prioritize opportunity areas.

📥 Stakeholder input gate — open before agents run.

**Step 1 — Competitive Analysis (Design Agent + Business Agent, mandatory):**

Before synthesizing insights, find out what competitors have already shipped in this
problem space. Skipping this risks reinventing — or shipping a worse version of —
something that already exists.

1. Identify 3–6 relevant competitor or adjacent products for the problem space.
2. Pull real screens and flows for each using the **Mobbin MCP** tools — `search_apps`,
   `get_app_screens`, `get_app_flows`, and `search_screens` / `search_flows` for
   pattern-specific searches. See Sprint Toolkit above for the full tool list.
3. If the Mobbin MCP isn't connected in this session, fall back to `WebFetch` against
   mobbin.com search results, and flag to the human that fallback results may be
   lower-fidelity or incomplete.
4. **Screenshots are required, not descriptions.** Never write "Competitor X has a
   clean onboarding flow" without an actual retrieved screenshot backing it. A text
   summary with no visual evidence is not evidence — mark it ⚠️ Assumed instead of
   presenting it as a finding.
5. Render retrieved screenshots directly in the Phase 2 board (Section A below) so
   the human sees the actual competitive landscape, not a paraphrase of it.

```
🔍 COMPETITIVE ANALYSIS
────────────────────────────────────────
[Competitor/Product]: [what they do in this space]
  ↳ Screenshot: [retrieved image — via Mobbin MCP or WebFetch fallback]
  ↳ Pattern: [the specific interaction or design pattern shown]
  ↳ Implication: [gap, bar to clear, or pattern to avoid copying]
```

Gap-check: if no real evidence could be retrieved for a claimed competitor pattern,
flag it — do not carry an unverified assumption into insight gathering.

**Step 2 — Insight Gathering:**
All core agents (+ approved secondary agents) synthesize insights through their lens.
All insights must include source citations and source quality rating.
→ See `references/agent-prompts.md` for each agent's reasoning pattern.

Gap-check: flag missing input sources before proceeding. Rate overall data quality.

**Step 3 — HMW Generation:**
Agents generate "How Might We" questions derived from their insights.
Each HMW traces back to the insight(s) that generated it.
Facilitator clusters into 3–5 themes.
📝 Content Agent reviews HMW phrasing for hedging and vagueness before clustering locks.

**Step 4 — Prioritization:**
Agents score themes against: impact, feasibility, principle alignment.
Facilitator presents scoring with rationale and source confidence level.

**Step 5 — Render insight board using show_widget**

After all agents complete their insight gathering, the Facilitator renders the
Phase 2 output as an interactive sprint board using show_widget. This replaces
walls of text with a visual research board the human can scan and interact with.

The board contains four sections:

**Section A — Competitive evidence strip**
The screenshots retrieved in Step 1 render first, as a horizontal strip of actual
screenshots with source app name and pattern label beneath each — before the
insight stickies below.

**Section B — Insight sticky notes (with tappable source links)**
Each insight is rendered as a colour-coded sticky note:
- Yellow = User Agent insights
- Blue = Business Agent insights
- Green = Data Agent insights
- Orange = System Agent insights
- Pink = Customer Success / secondary agent insights

Each sticky note must include:
- Agent label + insight category (e.g. "User · silent drift")
- Insight text (2 sentences max)
- Source quality dot: 🟢 strong / 🟡 moderate / 🔴 weak
- Tappable source link using `<a href="[real URL]" target="_blank">` — not a
  placeholder. If the source has a real URL, link to it directly. If it's an
  assumed or inferred source, omit the link and show "⚠️ Assumed" instead.

Sticky note footer format:
```html
<div class="sticky-footer">
  <span class="sticky-source">
    <span class="src-dot src-[green|yellow|red]"></span>[Quality]
  </span>
  <a class="sticky-link" href="[real URL]" target="_blank">[Short source name] ↗</a>
</div>
```

**Section C — HMW affinity map**
HMW questions grouped into clusters using dashed-border containers.
Each cluster has a theme label. Stickies inside match the agent colour of
the agent who generated the HMW.

**Section D — Priority themes**
Ranked themes shown as horizontal score bars with agent attribution.
Expand/collapse for scoring breakdown detail.

The board ends with a DP2 confirm card — summary of themes + Confirm/Edit buttons
that use sendPrompt() to proceed or go back.

**Collapsed detail rule:**
Every section has an expand trigger ("See full notes", "See scoring breakdown")
that reveals detail on tap. The default view is visual and scannable — not a
wall of text. Detail is available but not forced.

⏸️ **Decision Point 2:** Human reviews the visual board, confirms competitive
findings, themes, and priority order, or redirects before Phase 3 begins.

---

### 📍 Phase 3 — Diverge (Two-round ideation with agent voting)

**Goal:** Generate, sketch, and vote on ideas in two rounds — forcing genuine divergence
before convergence. Every idea must be made visible through a low-fidelity wireframe.
Human sees and reacts at every checkpoint.

📥 Stakeholder input gate — open before agents run.

---

**Round 1 — First burst of ideas**

**Step 1A — Generate 8 ideas:**
All core agents (+ active secondary agents) collaborate to generate exactly 8 ideas
across the top-rated opportunity areas from Phase 2.

Ideas are distributed across agents by lens — not one agent per idea, but each idea
tagged with which agent perspective it comes from.

Each idea format:
```
IDEA [1–8]: [Name]
Agent lens: [which agent perspective drives this]
What it is: [1-2 sentences — concrete, not abstract]
Why it matters: [which principle it serves]
Opportunity area: [which Phase 2 theme it addresses]
Source: [insight it came from, with source citation]
```

**Step 1B — Wireframe all 8 ideas (mandatory):**
Every idea must be made visible as a wireframe — this is not optional and is never
satisfied by a text description alone. Load the design skill stack (see Sprint
Toolkit — Anthropic Frontend Design, Impeccable, UI/UX Pro Max, Vercel Web Design
Guidelines, Vercel React Best Practices; invoke whichever are installed), then
generate a mid-fidelity wireframe for each of the 8 ideas via show_widget.
These are rough, fast, intentional — not polished UI. Goal: make thinking visible,
not make it pretty. If wireframes cannot be rendered for any reason, escalate to
the human before proceeding — never substitute a written description for the
missing wireframe.

**Wireframe rendering rules:**
Each wireframe follows this spec: a browser-framed HTML mockup — the same style as
the key screens in Phase 5, but intentionally rougher. Every wireframe must show:
- Browser chrome with a descriptive URL (e.g. "sprint.app / contention")
- One key screen or moment — the most critical interaction
- Real copy, not placeholder text ("Lorem ipsum" is forbidden)
- 2–3 floating annotation labels pointing to the key design decisions
- The agent lens that inspired the idea shown as a small badge

**Sketch vs polished distinction:**
- Sketch (Phase 3): rough layouts, minimal colour, boxes for images, key copy only
- Polished (Phase 5 Output 3): full design system, real visual language, all states

Present all 8 wireframes in a 2×4 grid using show_widget so the human can
compare ideas visually side by side. Below each wireframe: idea name, agent lens,
and vote count (empty at this stage — filled after voting).

```
┌─────────────────────────────────────────────────┐
│  #1 [Name]              #2 [Name]               │
│  [wireframe]            [wireframe]             │
│  [Agent] · 0 votes      [Agent] · 0 votes       │
│                                                  │
│  #3 [Name]              #4 [Name]               │
│  [wireframe]            [wireframe]             │
│  ...                    ...                     │
└─────────────────────────────────────────────────┘
```

After voting, re-render the grid with vote counts filled in and top-voted
ideas highlighted (indigo border + star badge).

**Step 1C — Agent voting (Round 1):**
Each agent votes for their top 3 ideas from the 8 — cannot vote for their own idea.
Agents must give a one-line reason for each vote, tied to a principle.

Vote format:
```
🗳️ ROUND 1 VOTING
────────────────────────────────────────────────
🧑‍💻 User Agent votes:     #[N] — [reason] · #[N] — [reason] · #[N] — [reason]
💼 Business Agent votes:  #[N] — [reason] · #[N] — [reason] · #[N] — [reason]
📊 Data Agent votes:      #[N] — [reason] · #[N] — [reason] · #[N] — [reason]
🏗️ System Agent votes:    #[N] — [reason] · #[N] — [reason] · #[N] — [reason]
🎨 Design Agent votes:    #[N] — [reason] · #[N] — [reason] · #[N] — [reason]
[Secondary agents if active]

TALLY:
#1 [Idea name]: ★★★★☆ (4 votes)
#2 [Idea name]: ★★★☆☆ (3 votes)
...

TOP 3 IDEAS: #[N], #[N], #[N]
SURPRISE: #[N] — voted for by unexpected agents
TENSION: #[N] vs #[N] — agents disagreed most here
────────────────────────────────────────────────
```

⏸️ **Human checkpoint 1:** Review 8 ideas, wireframes, and vote results.
→ React to what you see. Any ideas to kill? Any that surprised you?
→ Proceed to Round 2, or adjust direction first.

---

**Round 2 — Inspired by each other**

**Step 2A — Generate 8 new ideas:**
Agents now generate a second set of 8 ideas — this time inspired by what they saw
in Round 1. Cross-pollination is the goal: an idea from the User Agent might inspire
the System Agent to think differently. Ideas can combine, evolve, or deliberately
challenge the Round 1 top-voted concepts.

Rules for Round 2:
- Cannot repeat a Round 1 idea verbatim
- Must reference at least one Round 1 idea as inspiration
- At least 2 ideas must combine perspectives from different agents
- At least 1 idea must challenge the Round 1 top vote — "what if the opposite were true?"

Each idea format: same as Round 1, plus:
```
Inspired by: [Round 1 idea # and what it sparked]
```

**Step 2B — Wireframe all 8 new ideas (mandatory):**
Wireframe every Round 2 idea — the same non-negotiable requirement as Round 1,
with the design skill stack loaded. Same format as Round 1 — rough browser-framed
mockup, real copy, 2–3 annotations. Cross-pollination should be visible in the
wireframe — if idea #9 combines #3 and #7 from Round 1, the wireframe should
visually reference both.

Present all 8 Round 2 wireframes in a 2×4 grid, same style as Round 1.
After Round 2 voting, render a combined view: all 16 ideas with vote counts,
clearly marking which ideas climbed, held, or fell between rounds.

**Carry-forward highlight:**
After DP3 confirmation, render the 4 selected ideas as a focused 2×2 grid
with a "Carrying into Phase 4" label — this becomes the handoff board for convergence.

**Step 2C — Agent voting (Round 2):**
Agents vote across the full pool — Round 1 + Round 2 ideas combined.
Each agent picks their top 3 from the full 16.

Vote format: same as Round 1, but labeled Round 2 Voting.
Tally shows movement: did Round 2 ideas displace Round 1 leaders?

```
🗳️ ROUND 2 VOTING (full pool of 16)
────────────────────────────────────────────────
[same format as Round 1]

MOVEMENT:
→ Ideas that climbed: [which Round 2 ideas overtook Round 1 leaders]
→ Ideas that held: [which Round 1 ideas survived both rounds]
→ Ideas that fell: [which Round 1 top-voted ideas lost support]

FINAL TOP IDEAS GOING INTO CONVERGENCE:
#[N], #[N], #[N] — carried forward to Phase 4
────────────────────────────────────────────────
```

⏸️ **Decision Point 3:** Human reviews Round 2 ideas, wireframes, and final vote tally.
→ Confirm which ideas carry forward into Phase 4.
→ Can add ideas to carry forward, remove any, or flag a tension to resolve first.

---

### 📍 Phase 4 — Converge (Agents as a team)

**Goal:** Take the top-voted ideas from Phase 3 and converge them into one group solution —
designed around a real user story, connected into flows, tested against real behavior.

📥 Stakeholder input gate — open before convergence runs.

---

**Step 1 — Identify up-voted concepts and patterns:**

Facilitator reads across all Phase 3 voting to surface:
- Which ideas won across multiple rounds (durable signal)
- Which patterns appear across multiple ideas (recurring motif worth keeping)
- Which tensions between top ideas need resolving before combining

```
🧭 PATTERN RECOGNITION
────────────────────────────────────────────────
DURABLE IDEAS (top-voted across both rounds):
• [Idea] — voted by [agents], survived [rounds]
• [Idea] — voted by [agents], survived [rounds]

RECURRING PATTERNS (appear in multiple ideas):
• [Pattern] — seen in ideas #[N], #[N], #[N]
  → Worth making a core part of the group solution

TENSIONS TO RESOLVE:
• [Idea A] vs [Idea B] — incompatible because [reason]
  → Group must pick one or find a synthesis
────────────────────────────────────────────────
```

---

**Step 2 — Agents work as a team to build one group solution:**

This is the critical shift. Agents stop competing and start collaborating.
Every agent contributes their perspective to ONE unified solution.

The group solution must:
- Incorporate the top-voted patterns from both rounds
- Resolve the tensions identified above
- Pass all confirmed principles
- Be expressed as a named concept with a clear point of view

Group solution format:
```
🤝 GROUP SOLUTION: [Name]
────────────────────────────────────────────────
Concept: [1 sentence — what this is]
Point of view: [what makes this distinctively ours]

Each agent's contribution:
🧑‍💻 User: [what this does for the user]
💼 Business: [how this creates value]
📊 Data: [what signal this uses or generates]
🏗️ System: [how this is structured underneath]
🎨 Design: [what makes this visually and experientially distinctive]
[Secondary agents if active]

Principles passed:
P2 ✅/⚠️  P3 ✅/⚠️  P5 ✅/⚠️  P6 ✅/⚠️
────────────────────────────────────────────────
```

---

**Step 3 — Think like a real user. Build the story and flow:**

Before wireframing the group solution, agents run a story test:
write the experience as a real user living through it — not a feature description,
a human moment. If the story doesn't feel natural, the solution has a gap.

Story format:
```
👤 USER STORY
────────────────────────────────────────────────
Character: [Name], [brief description — real person, not a persona archetype]
Situation: [specific moment — not "a user wants to..." but "It's Thursday evening
           and Maya just realized her best friend's birthday is in 4 days..."]

Step by step — what Maya actually does:
1. [She opens the app because...]
2. [She sees... and feels...]
3. [She does... and the product responds with...]
4. [The moment of truth: does the solution solve the problem?]
5. [How does she feel at the end?]

Does the solution solve Maya's problem? ✅ / ⚠️ / ❌
Where does the story break or feel unnatural? [specific moment]
What's missing from the solution to make this story work?
────────────────────────────────────────────────
```

If the story breaks → agents identify the gap and patch the solution before flows.
If the story holds → proceed to storyboarding.

---

**Step 3b — Storyboard first, Mobbin first (mandatory before final screens):**

Before designing final hi-fidelity screens, storyboard the journey as a sequence
of rough panels — comic-strip style — mapped 1:1 to the user story steps from
Step 3. This locks the *sequence and moments* before locking pixels.

For each storyboard panel:
1. **Storyboard it** — one panel per story beat: who's on screen, what state
   they're in, what they see and do. Simple boxes with a 1-line caption — not a
   wireframe yet.
2. **Mobbin it** — before designing the panel, search Mobbin (`search_screens` /
   `search_flows`, filtered to the relevant pattern — e.g. "onboarding interview,"
   "comparison result") for real shipped examples of this exact moment. Pull 2–3
   reference screens per panel.
3. **Design it** — only once the panel and its references are set, produce the
   final hi-fidelity screen for that panel with the design skill stack loaded
   (see Sprint Toolkit), using the Mobbin references as grounding — not to copy,
   but to know the bar and avoid reinventing a solved pattern.

Storyboard panel format:
```
PANEL [N]: [story beat this maps to]
Who/state: [character, emotional state]
Sees/does: [what happens in this panel]
Mobbin references: [2-3 screens pulled, with source app name + link]
→ Design once panel is confirmed
```

Skip storyboarding only if the flow has 2 or fewer screens — for anything longer,
storyboard-first is mandatory before final screens are built.

---

**Step 4 — Connect concepts into flows using show_widget:**

Agents produce a connected flow — not isolated screens, but the full journey
from trigger to resolution, using the group solution.

**Flow rendering rules:**
The Facilitator renders the connected flow as an interactive show_widget board:

**Section A — Flow map (top strip)**
A horizontal sequence of screen thumbnails connected by arrows showing:
- Each screen as a small labelled node
- The transition trigger between screens (tap, scroll, AI response, time)
- The key AI moment or decision point marked with a distinct badge
- Any branches or edge cases shown as secondary paths below the main flow

**Section B — Key screens (main section)**
For each major screen in the flow, produce a full browser-framed wireframe —
mandatory, not optional, same as Phase 3, with the design skill stack loaded —
using the storyboard panel and Mobbin references from Step 3b as grounding. Same
quality level as Phase 3 wireframes but showing the actual group solution, not a
rough concept. Render via show_widget. Each screen includes:
- Browser chrome with real URL
- Real copy reflecting the confirmed group solution name and tone
- 3–4 annotation labels per screen: what user sees, what they do,
  what AI does, and which principle this moment expresses
- Principle badge (e.g. "D1 ·  visible reasoning") on the annotation
  that is most clearly expressing a design principle

**Section C — Story test overlay (collapsible)**
An expand trigger reveals the user story mapped onto the flow:
- Each story step pinned to the relevant screen in the flow
- Emotional state shown at each moment (the "feels like" label from the story)
- Gap flag if a story step has no screen — shown as a red dotted outline

**Section D — DP4 + DP5 confirm card**
Facilitator synthesis summary + human decision card at the bottom.
Two buttons: "Approve and proceed to Phase 5" and "Flag a gap and rework."

Flow structure text format (for reference, rendered visually):
```
TRIGGER → [what causes the user to open the product]
    ↓
SCREEN 1: [name] — [what user sees and does]
    ↓
SCREEN 2: [name] — [what user sees and does]
    ↓
[key AI moment / decision point]
    ↓
SCREEN 3: [name] — [resolution or next step]
    ↓
OUTCOME: [how the user feels — and what the product learned]
```

Facilitator then runs final checks:

```
🧭 FACILITATOR SYNTHESIS
════════════════════════════════════════════════
[See full format in Responsibility 3 above]

STORY TEST RESULT: ✅ holds / ⚠️ gaps found / ❌ needs rework

FLOW COHERENCE:
• Does each screen lead naturally to the next?
• Is the AI's role clear at every step?
• Where might a real user hesitate or drop off?

RECOMMENDED DIRECTION: [Group solution name]
ALTERNATIVE: [if story test revealed a fallback]
THE DECISION ONLY YOU CAN MAKE: [human judgment call]
SUGGESTED NEXT STEP: [one action, one owner, one deadline]
════════════════════════════════════════════════
```

⏸️ **Decision Point 4:** Human reviews group solution, user story, and connected flow.
→ Does the story feel true? Does the flow solve the problem?
→ Approve for Phase 5, or identify which part of the story breaks and needs fixing.

⏸️ **Decision Point 5 (Final):** Human makes the call.

→ See `references/convergence-guide.md` for full scoring and recommendation formats.

---

### 📍 Phase 5 — Build (Agent-executed)

**Goal:** Translate sprint direction into four artifacts — for the team, leadership, design
and engineering, and stakeholders who weren't in the room.

Phase 3 wireframes are the foundation — Phase 5 refines and finalizes them, it does not
start from scratch.

📥 Stakeholder input gate — open before build artifacts are created.

**Wireframe continuity rule:**
The preferred sketch selected at Decision Point 3 anchors Phase 5 design work.
Design Agent refines Phase 3 sketches into final-fidelity screens — mandatory,
same as Phase 3/4, with the design skill stack loaded — then renders via
show_widget. New screens are added only where Phase 3 sketches left gaps.

**Rendering approach for Output 3 and Output 4:**
All key screens are rendered as high-fidelity HTML mockups using show_widget — not
placeholder boxes. Every screen must show real UI: actual conversation flows, real copy,
real interaction states, real visual language from the confirmed design principles.
Each rendered screen includes:
- Browser chrome with URL
- Actual content (not "Lorem ipsum" or grey boxes)
- Annotations explaining the key design decision on that screen

**Content pass:** the Content Agent runs a full writing pass on all five outputs
before any of them is shown to the human — see Content Agent under Meta-Roles.

**Optional: export to Google Workspace.** Ask the human once, before producing
outputs: "Want these exported to Google Docs/Slides as we go — Build Brief and
Executive Brief to Docs, Sprint Recap Deck to Slides? I can help you connect the
Google Workspace MCP if you'd like." Only proceed if the human says yes — never
install or connect it automatically. If declined, or the MCP isn't available, all
outputs are still produced natively (show_widget / pptxgenjs / markdown) with no
loss of functionality.

**If the human says yes and the MCP isn't connected yet**, guide the install —
don't just say "connect it and come back":

1. **Check first** — Google Docs/Drive/Slides/Calendar tools may already be
   connected in the session (look for Google Workspace tools in the available
   tool list, including deferred tools). If present, skip install entirely.
2. **Connector directory (Claude app / Cowork / claude.ai):** if a connector
   directory or MCP registry tool is available in the session, use it to surface
   the Google Workspace / Google Drive / Google Slides connector so the human can
   approve it in the app's own UI — the OAuth consent screen is theirs to click
   through, never Claude's.
3. **Claude Code CLI:** tell the human to run `claude mcp add` for the Google
   Workspace MCP server they prefer, or point them to Settings → Connectors.
   Claude may draft the exact command, but the human runs or approves it.
4. **Auth stays with the human.** Never enter Google credentials, click through
   OAuth consent, or approve scopes on the human's behalf — pause and hand off
   whenever a sign-in screen appears.
5. **Resume gracefully.** Once connected, verify with a lightweight read-only
   call (e.g. list recent files) before exporting. If the human abandons the
   install midway, fall back to native outputs without re-asking.

Five outputs are produced in priority order: Output 4 → Output 3 → Output 1 → Output 2 → Output 5 (auto, 2 days later)

---

**Output 4: Sprint Recap Deck** ← produce first
Owned by Sprint Facilitator.
Audience: stakeholders who weren't in the room.
Purpose: tell the story of how you got to the decision, not just what the decision was.

Every slide uses rendered visuals — no placeholder boxes. Produce using show_widget or
a PPTX generation script (pptxgenjs). Render key screens as actual HTML/CSS mockups and
embed them into the relevant slides.

Slide structure:
```
Slide 1  — Cover (product name, sprint type, tagline)
Slide 2  — The problem (Phase 1: problem statement + user types + key stat)
Slide 3  — Confirmed principles (product principles + design principles, rendered)
Slide 4  — What we learned (Phase 2: 6 themes grid with agent attribution, rendered)
Slide 5  — Two rounds of ideation (Phase 3: all 16 ideas, vote tallies, what carried forward)
Slide 6  — The group solution (Phase 4: concept name + all agent contributions, rendered)
Slide 7  — Story test (Phase 4: character + 6-step journey + verdict, rendered)
Slide 8  — Key screens 1+2 (actual high-fidelity UI, dark background)
Slide 9  — Key screens 3+4 (actual high-fidelity UI, dark background)
Slide 10 — End-to-end flow (4 screens in sequence + story steps mapped below)
Slide 11 — The decision (recommendation + the human call + next step)
Slide 12 — What we're building (12-week plan + metrics + out-of-scope)
Slide 13 — Next step (one action, one owner, one deadline — close slide)
```

**Deck rendering rules:**
- Every slide that describes a feature or screen must show actual rendered UI
- Dark slides (#2C2C2C background) for group solution and key screens — creates contrast
- Warm off-white (#FAF7F2) for all other slides
- Terracotta (#C4785A) as the accent — headers, highlights, CTAs
- Georgia serif for titles, Calibri/Arial for body
- No placeholder boxes, no wireframe-style grey rectangles in the final deck

---

**Output 3: End-to-end flow + key screens** ← produce second
Owned by Design Agent + System Agent.
Audience: the team building the product (design + engineering).
Purpose: replace the design system doc — what the team actually needs is the flow and
screens, not a token list. They can extract tokens from the screens.

Render ALL key screens using show_widget as high-fidelity HTML mockups:
- Browser chrome with real URL
- Real copy, real interaction states, real visual language
- Fit/miss guide, conversation bubbles, relationship arc — all rendered properly
- Annotations per screen explaining the key design decision

Screen set (minimum for web app):
```
Screen 1: Homepage — the invitation (no account, one CTA)
Screen 2: Relationship interview — conversation, live tags
Screen 3: Warm reveal — one rec, fit/miss guide side by side
Screen 4: Account prompt — value shown before ask
Screen 5: Dashboard — relationship arc, circle view
Screen 6: Loop close — how did it land? one tap
```

Flow document structure:
```
FLOW: [trigger → screen 1 → screen 2 → ... → outcome]
Per screen:
  - What the user sees
  - What they do
  - What the system does next
  - Key design decision annotated
Edge cases:
  - Returning user (known relationship → skip to recs)
  - Second gift (profile already built)
  - No profile yet (cold start)
```

---

**Output 1: Build Brief** ← produce third
Owned by System Agent + Business Agent + Quality Agent (if active).
Audience: the team building the product.

```
🏗️ BUILD BRIEF
════════════════════════════════════════════════
What we're building: [chosen direction, 1-2 sentences]
Why: [rationale from sprint — connects to principles]
Owner: [team / person accountable]

Success metrics:
• [Metric 1 + target]
• [Metric 2 + target]

Scope (in):
• [what's included in v1]

Scope (out):
• [explicitly excluded to keep v1 focused]

Technical starting point: [System Agent input]
Acceptance criteria: [Quality Agent if activated]
Launch criteria: [Marketing Agent if activated]

Next action: [one specific thing, owner, deadline]
════════════════════════════════════════════════
```

---

**Output 2: Executive Brief** ← produce last
Owned by Executive Agent.
Audience: leadership, board, stakeholders.
Purpose: translate sprint output into the language leadership cares about —
vision alignment, strategic fit, business impact, resource ask, and risk.
This is NOT a decision-making document — it prepares the human to walk into
any exec conversation fully prepared.

```
🎯 EXECUTIVE BRIEF
════════════════════════════════════════════════
FOR: [Leadership / Board / Stakeholders]
RE:  [What we're building — one line]

VISION & MISSION ALIGNMENT
→ [How this connects to company vision]
→ [How this advances the mission]

STRATEGIC FIT
→ [How this maps to current company goals / OKRs]
→ [What strategic bet this represents]

WHY NOW
→ [Market signal, user signal, or competitive context]

WHAT WE'RE ASKING FOR
→ Resources: [team, time, budget]
→ Decision needed: [what leadership needs to approve]

EXPECTED IMPACT
→ [Metric 1 + target]
→ [Metric 2 + target]

RISK & MITIGATION
→ [Key risk and how we're managing it]

WHAT HAPPENS IF WE DON'T DO THIS
→ [Opportunity cost or competitive consequence]

DESIGN DIFFERENTIATION
→ [What makes this visually and experientially
   different from what's already in market]
════════════════════════════════════════════════
```

---

**Output 5: Decision Quality Score** ← runs 2 days after sprint closes
Owned by Sprint Facilitator.
Audience: the designer who ran the sprint.
Purpose: close the learning loop. Turn the decision log into a learning system — not just
a record of what happened, but a signal about which phases and decision points need more
rigor next time.

**Trigger:** 2 days after sprint end. Facilitator sends a lightweight nudge (email or
in-tool message). Subject: "How did [project name] sprint decisions hold up?"

**Format:**
```
🧭 DECISION QUALITY CHECK
────────────────────────────────────────────────────
How did your sprint decisions hold up?
Rate each 1–3. Pattern appears immediately. Takes 60 seconds.

[DP1] [what was decided]    [1 wrong] [2 ok] [3 right]
[DP2] [what was decided]    [1 wrong] [2 ok] [3 right]
[DP3] [what was decided]    [1 wrong] [2 ok] [3 right]
[DP4] [what was decided]    [1 wrong] [2 ok] [3 right]
[DP5] [what was decided]    [1 wrong] [2 ok] [3 right]

PATTERN:
[Which DP scored lowest and what it means for next sprint]
→ [One specific suggestion for next sprint]
────────────────────────────────────────────────────
```

**Pattern rules:**
- Show pattern immediately after rating — not stored in a dashboard nobody visits
- Pattern references the specific DP, not generic advice
- One suggestion only — concrete and actionable
- Store ratings in sprint-brief.md under Sprint history for cross-sprint comparison

**Cross-sprint learning** (after 3+ sprints):
```
## Sprint history (in sprint-brief.md)
Sprint 1: DP3 weakest (2/3) — carry-forward decisions
Sprint 2: DP2 weakest (2/3) — theme prioritization
Sprint 3: Pattern — Phase 3 → Phase 4 transition is consistently weakest
Suggestion: Add more time to Round 2 voting before carrying forward
```

**On web/async:** Re-engagement relies on email. Must be opt-in at account or session
creation. One-click link back to the quality check screen — no login wall on return.

⏸️ **Decision Point 6:** Human approves all five outputs before execution begins.
Decision Quality Score runs automatically 2 days later — no further approval needed.

---

## Sprint Modes

### Full Sprint
All 5 phases with all decision points and stakeholder input gates active.
Default for new products or complex, high-stakes decisions.
Recommended timebox: 1 hour (compressed) · 3 days (standard) · 1 week (deep/high-stakes)
**A 1-hour timebox still runs all 5 phases** — see the note under "Timebox
adjustment rules" below. Only agent output depth scales down, never the phase count.

### Express Sprint
Phase 1 (abbreviated) → Phase 2 (core agents only) → Phase 4 (convergence).
Decision Points 1 and 5 still required. Others skipped.
Recommended timebox: under 30 minutes, or by explicit human request to skip phases
regardless of time available.
**Do not default to Express Sprint just because the timebox is short.** A 1-hour
timebox runs the Full Sprint, not Express — see "Timebox adjustment rules" below.

### Single Agent Mode
Run one agent's analysis on demand. Output: Insights → HMWs → Implications.
Source citations still required. No decision points needed.
No timebox needed — run as long as useful.

### Timebox adjustment rules
When a timebox is active, the Facilitator scales agent output depth automatically.
**All rows below assume all 5 phases run — only depth changes, never the phase
count** — unless the human explicitly requests Express Sprint or Single Agent Mode.

| Time available | Agent output depth |
|---|---|
| < 30 min | Top 3 insights only · 2 HMWs · no source deep-dives |
| 30–60 min | 5 insights · 3–4 HMWs · key sources cited |
| 60–90 min | Full output · all sources · full HMW set |
| No limit | Full output + extended source research on request |

**1-hour timebox, concretely:** Phase 1 and 2 compress to top insights only, Phase 3
(Diverge) may reduce to a single round instead of two if time is tight — flag this
trade-off explicitly and get the human's confirmation before cutting it — Phase 4
stays fully intact (it's the convergence the sprint exists to reach), and Phase 5
produces Build Brief + key screens first, with Executive Brief, Deck, and the
Decision Quality Score following async if time runs out.

If a phase runs over the timebox target, Facilitator flags and asks:
→ "We're at [X min] on Phase [N] — want to wrap and move on, or keep going?"
Never cuts off silently. Always human's call.

---

## Sprint Review Page Template

Created once, immediately after the timebox is confirmed in Phase 1 (before problem
input is gathered), and updated at every Decision Point after that. Built and shared
via the Artifact tool as a live, shareable Vibe page — never a local file.

```
[Project name] — Sprint Review
─────────────────────────────────────────
Status: Phase [N] of 5 · [in progress / DP[N] confirmed]
Timebox: [mode] · [target] · [elapsed]

PROBLEM
[sharpened problem statement once confirmed at DP1]

PRINCIPLES
Product: [P1-P4 once confirmed]
Design: [D1-D3 once confirmed]
Success metrics: [M1-M3, confirmed alongside principles]

DECISION LOG
[DP1] [what was decided]
[DP2] [what was decided]
...

CURRENT RECOMMENDATION
[Facilitator synthesis recommendation, once Phase 4 completes]

LINKS
Sprint Recap Deck · Build Brief · Executive Brief · Flow + Key Screens
```

Share the link with the human as soon as it's created — before Goal / Problem
statement / Constraints are gathered — so they have somewhere to point stakeholders
throughout the sprint, not just at the end.

---

## Reference Files

- `INSTALL.md` — One-time setup guide: installing the skill, the Google Workspace
  MCP, the Mobbin MCP, and the recommended design skill stack
- `references/agent-prompts.md` — Reasoning patterns for all core, secondary, and
  cross-cutting agents (5 core + 6 secondary + Content)
- `references/convergence-guide.md` — HMW scoring, idea evaluation, final recommendation format
- `references/writing-guide.md` — Content principles applied by the Content Agent:
  voice, tone, and copy rules for every phase

Read these when running a full sprint or when you need deeper guidance on a specific phase.
