# Installing Agentic Sprint

One-time setup for the skill and its companion tools. Do this once; every sprint
after that just starts with `/agentic-sprint`.

---

## 1. Install the skill itself

**Claude app / claude.ai / Cowork**
1. Go to **Settings → Capabilities → Skills** (naming varies slightly by surface).
2. Upload `agentic-sprint.skill`.
3. Confirm it appears in your skills list as **agentic-sprint**.

**Claude Code (CLI / desktop)**
1. Unzip the package into your skills directory:
   ```
   unzip agentic-sprint.skill -d ~/.claude/skills/
   ```
   You should end up with `~/.claude/skills/agentic-sprint/SKILL.md`.
2. Start a new session — the skill is picked up automatically and can be invoked
   with `/agentic-sprint`.

**Cursor (2.4+)**

Cursor reads the same Agent Skills format, so no changes are needed. It also
auto-loads `~/.claude/skills/`, so the step above already makes it available.
To keep it in Cursor's own directory instead:
   ```
   unzip agentic-sprint.skill -d ~/.cursor/skills/
   ```
Restart Cursor, then invoke `/agentic-sprint` in Agent chat (or just describe
your problem and the agent applies it when relevant).

For a **project-scoped** install in either tool, unzip into the repo's
`.claude/skills/` or `.cursor/skills/` folder instead of the `~` home path.

---

## 2. Install the Google Workspace MCP (optional but recommended)

Used in Phase 5 to export the Build Brief and Executive Brief to Google Docs and
the Sprint Recap Deck to Google Slides. The sprint works fully without it — outputs
fall back to native rendering (show_widget / pptxgenjs / markdown).

**Claude app / claude.ai / Cowork**
1. Go to **Settings → Connectors**.
2. Find **Google Drive** / **Google Workspace** in the connector directory and
   click **Connect**.
3. Sign in with your Google account and approve the requested scopes on Google's
   own consent screen. (Claude never handles your credentials — you click through
   OAuth yourself.)

**Claude Code (CLI)**
1. Add the server (example — use the Google Workspace MCP server of your choice):
   ```
   claude mcp add google-workspace -- npx -y @your-preferred/google-workspace-mcp
   ```
2. On first use you'll be sent through Google's OAuth flow in the browser —
   approve the scopes there.
3. Verify with a read-only call (e.g. ask Claude to list your recent Drive files).

If you skip this now, the sprint will offer it again — with your consent — at the
start of Phase 5.

---

## 3. Install the Mobbin MCP (recommended)

Used in Phase 2 (Competitive Analysis) and Phase 4 (Mobbin-first design) to pull
real screenshots and flows from shipped products. Requires a Mobbin account.

**Claude app / claude.ai / Cowork**
1. **Settings → Connectors** → find **Mobbin** → **Connect** → sign in to Mobbin.

**Claude Code (CLI)**
1. Follow Mobbin's MCP setup instructions (mobbin.com → developer/MCP docs), then:
   ```
   claude mcp add mobbin -- [command from Mobbin's docs]
   ```

Without it, the skill falls back to `WebFetch` against mobbin.com — functional but
lower-fidelity, and the skill will flag this to you during the sprint.

---

## 4. Install the design skill stack (recommended)

Wireframing in Phases 3–5 is mandatory, and these public skills set the craft
standard for it. Install any or all of them the same way as step 1 (from their
respective marketplaces / skill directories):

| Skill | Used for | Required? |
|---|---|---|
| Anthropic Frontend Design | Baseline craft standard for generated UI | Recommended |
| Impeccable | Polish, spacing, typographic rigor | Recommended |
| UI/UX Pro Max | Interaction patterns and UX heuristics | Recommended |
| Vercel Web Design Guidelines | Layout, hierarchy, accessibility | Recommended |
| Vercel React Best Practices | Wireframes rendered as React/HTML | Recommended |

None of these is strictly required — wireframes are still generated (and still
mandatory) without them, applying their principles from memory. The sprint invokes
whichever are installed before designing, so the more of the stack you have, the
higher the wireframe quality bar.

---

## 5. Verify the install

Start a new session and run through this checklist:

- [ ] `/agentic-sprint` renders the terminal welcome screen
- [ ] Design skill stack: the skills you installed in step 4 appear in your skills list
- [ ] Mobbin MCP: ask "search Mobbin for onboarding screens" — real screenshots return
- [ ] Google Workspace MCP (if installed): ask to list recent Drive files — results return

All four green → you're ready to run a sprint.
