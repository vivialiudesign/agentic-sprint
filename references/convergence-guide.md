# Convergence Guide

How to structure evaluation, scoring, and final selection in Stages 4–7.

---

## Stage 4: HMW Prioritization

After all agents generate HMWs, cluster and score them:

### Clustering
Group HMWs into 3–5 themes. Name each theme. Example:
- **Onboarding clarity** — 4 HMWs
- **Trust building** — 3 HMWs
- **Advanced user power** — 5 HMWs

### Scoring Matrix
Score each theme (not individual HMWs) against three dimensions:

| Dimension | 1 (Low) | 3 (Medium) | 5 (High) |
|---|---|---|---|
| **Impact** | Affects few users / low value | Moderate user base / medium value | Core user base / high value |
| **Feasibility** | Requires major rework | Moderate complexity | Can ship fast |
| **Principle alignment** | Conflicts with stated principles | Partial alignment | Fully aligned |

**Total score = Impact + Feasibility + Principle alignment (max 15)**

Present as:
```
THEME: [Name]
HMWs included: [count]
Impact: ★★★★☆ (4)
Feasibility: ★★★☆☆ (3)
Principle alignment: ★★★★★ (5)
Total: 12/15
Agents supporting: User, Business
Key tension: System agent flags duplication risk
```

---

## Stage 6: Idea Evaluation

For each idea generated in Stage 5, run structured evaluation:

### Evaluation Template
```
IDEA: [Name]
One-liner: [What is it?]

AGENT SCORES:
🧑‍💻 User fit:        ★★★★☆  — [1 sentence rationale]
💼 Business impact:  ★★★☆☆  — [1 sentence rationale]
📊 Data support:     ★★★★★  — [1 sentence rationale]
🏗️ System fit:       ★★☆☆☆  — [1 sentence rationale]

OVERALL: ★★★★☆ (avg)

TRADE-OFFS:
✅ Strengths: [2-3 bullet points]
⚠️  Risks: [2-3 bullet points]
❌ Conflicts: [any principle or system conflicts]

RECOMMENDATION: [Proceed / Iterate / Kill]
RATIONALE: [1-2 sentences]
```

---

## Stage 7: Critique Patterns

Agents should actively critique — not just score. Use these critique lenses:

### Gaps
"This idea addresses X but leaves Y completely unresolved. Users who [scenario] will still
face [problem]."

### Conflicts
"This feature creates terminology conflict with [existing feature]. Users familiar with the
current system will be confused by [specific behavior]."

### Redundancy
"This overlaps significantly with [existing feature]. Before building new, consider whether
[existing feature] could be extended to address this."

### System entropy
"Adding this increases the number of ways a user can accomplish [task] to [N]. This
fragmentation may hurt discoverability and learnability."

### Assumption surfacing
"This idea assumes [assumption]. If that assumption is wrong — e.g., [counter-scenario] —
the idea fails. We should validate before committing."

---

## Final Recommendation Format

After Stage 7, present the human with a clear decision package:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
AGENTIC SPRINT: FINAL RECOMMENDATION
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

PROBLEM SPACE: [Prioritized theme]

RECOMMENDED DIRECTION: [Idea name]
Why: [2-3 sentences connecting to principles and agent consensus]

RUNNER-UP: [Idea name]
Consider if: [condition under which this becomes preferred]

KEY DECISION YOU NEED TO MAKE:
→ [The one human judgment call that agents can't resolve]

RISKS TO WATCH:
• [Risk 1]
• [Risk 2]

SUGGESTED NEXT STEP:
[Specific, actionable recommendation for what to do in the next 48 hours]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

## Convergence Principles

The goal of convergence is **decision quality**, not consensus.

1. **Principles over votes** — Score against stated principles, not personal preference
2. **Surface tensions explicitly** — Don't paper over agent disagreements
3. **Reduce cognitive load** — The human should get 1 clear recommendation + 1 alternative, not 10 options
4. **Name the human decision** — Always identify what judgment call only a human can make
5. **Bias toward action** — End with a specific next step, not open questions
