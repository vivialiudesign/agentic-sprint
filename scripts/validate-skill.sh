#!/usr/bin/env bash
# Validate the Agentic Sprint skill repository.
#
# Checks:
#   1. Required source files exist.
#   2. SKILL.md has valid YAML frontmatter with a name + description.
#   3. Every referenced references/*.md file exists and is non-empty.
#   4. The bundled agentic-sprint.skill archive is in sync with the source
#      files (same set of files, identical contents).
#
# Exits non-zero on the first failing check. Safe to run repeatedly.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

BUNDLE="agentic-sprint.skill"
SOURCES=(
  "SKILL.md"
  "INSTALL.md"
  "references/agent-prompts.md"
  "references/convergence-guide.md"
  "references/writing-guide.md"
)

fail() { echo "FAIL: $*" >&2; exit 1; }
ok()   { echo "  ok  $*"; }

echo "== 1. Required files present =="
for f in "${SOURCES[@]}" "$BUNDLE"; do
  [ -f "$f" ] || fail "missing required file: $f"
  [ -s "$f" ] || fail "file is empty: $f"
  ok "$f"
done

echo "== 2. SKILL.md frontmatter =="
python3 - "$@" <<'PY'
import sys, re, yaml, pathlib

text = pathlib.Path("SKILL.md").read_text(encoding="utf-8")
m = re.match(r"^---\n(.*?)\n---\n", text, re.DOTALL)
if not m:
    sys.exit("FAIL: SKILL.md is missing a leading YAML frontmatter block")

try:
    meta = yaml.safe_load(m.group(1))
except yaml.YAMLError as e:
    sys.exit(f"FAIL: SKILL.md frontmatter is not valid YAML: {e}")

if not isinstance(meta, dict):
    sys.exit("FAIL: SKILL.md frontmatter did not parse to a mapping")

name = meta.get("name")
desc = meta.get("description")
if name != "agentic-sprint":
    sys.exit(f"FAIL: expected frontmatter name 'agentic-sprint', got {name!r}")
if not isinstance(desc, str) or not desc.strip():
    sys.exit("FAIL: frontmatter 'description' is missing or empty")

print(f"  ok  name = {name}")
print(f"  ok  description present ({len(desc.strip())} chars)")
PY

echo "== 3. Reference integrity =="
python3 - <<'PY'
import re, pathlib, sys

refs = set()
for doc in ("SKILL.md", "INSTALL.md"):
    text = pathlib.Path(doc).read_text(encoding="utf-8")
    refs |= set(re.findall(r"references/[A-Za-z0-9._-]+\.md", text))

if not refs:
    sys.exit("FAIL: no references/*.md links found in SKILL.md / INSTALL.md")

missing = [r for r in sorted(refs) if not pathlib.Path(r).is_file()]
if missing:
    sys.exit("FAIL: referenced files do not exist: " + ", ".join(missing))

for r in sorted(refs):
    print(f"  ok  {r}")
PY

echo "== 4. Bundle in sync with source =="
python3 - "$BUNDLE" <<'PY'
import sys, zipfile, pathlib

bundle = sys.argv[1]
sources = [
    "SKILL.md",
    "INSTALL.md",
    "references/agent-prompts.md",
    "references/convergence-guide.md",
    "references/writing-guide.md",
]

zf = zipfile.ZipFile(bundle)
names = {n for n in zf.namelist() if not n.endswith("/")}
expected = {f"agentic-sprint/{s}" for s in sources}

extra = names - expected
if extra:
    sys.exit("FAIL: bundle contains unexpected files: " + ", ".join(sorted(extra)))

for s in sources:
    entry = f"agentic-sprint/{s}"
    if entry not in names:
        sys.exit(f"FAIL: bundle is missing {entry}")
    bundled = zf.read(entry)
    on_disk = pathlib.Path(s).read_bytes()
    if bundled != on_disk:
        sys.exit(f"FAIL: bundle content differs from source for {s} "
                 f"(bundle={len(bundled)}B, source={len(on_disk)}B). "
                 f"Run scripts/build-skill.sh to rebuild.")
    print(f"  ok  {s} matches bundle ({len(on_disk)}B)")
PY

echo
echo "Skill validation passed."
