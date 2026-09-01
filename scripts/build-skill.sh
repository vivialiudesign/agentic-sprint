#!/usr/bin/env bash
# Rebuild the distributable agentic-sprint.skill bundle from the source files.
#
# The bundle is a plain zip whose top-level directory is "agentic-sprint/"
# (matching the layout INSTALL.md expects users to unzip into their skills
# directory). Run this after editing SKILL.md, INSTALL.md, or references/*.md,
# then commit the regenerated bundle.
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

for f in "${SOURCES[@]}"; do
  [ -f "$f" ] || { echo "ERROR: missing source file: $f" >&2; exit 1; }
done

STAGE="$(mktemp -d)"
trap 'rm -rf "$STAGE"' EXIT

PKG="$STAGE/agentic-sprint"
mkdir -p "$PKG/references"
cp SKILL.md INSTALL.md "$PKG/"
cp references/*.md "$PKG/references/"

rm -f "$BUNDLE"
( cd "$STAGE" && zip -q -r -X "agentic-sprint.skill" "agentic-sprint" )
mv "$STAGE/agentic-sprint.skill" "$BUNDLE"

echo "Built $BUNDLE:"
unzip -l "$BUNDLE"
