#!/usr/bin/env bash
#
# Refuse anything that looks like it came from a real document.
#
#   ./scripts/check-boundary.sh            # every tracked file
#   ./scripts/check-boundary.sh --staged   # what is about to be committed
#
# ## Why this exists
#
# This repository is **public**, and its one hard rule — bed runs only,
# wholly synthetic fixtures, nothing derived from a person's papers —
# lived in a README sentence and in whoever was committing at the time.
# A public repository makes a slip permanent: deleting a file does not
# unclone it. So the rule gets a mechanism.
#
# ## What it catches, and what it does not
#
# It catches the **file-shaped** mistake: a path carrying the
# `*.private.<ext>` naming that kettle's `.gitignore` reserves for real
# documents, or a run directory with no MANIFEST saying what it is.
# That is the mistake a tired person actually makes — dragging a
# directory across without looking at what is in it.
#
# It cannot read content. A real letter OCR'd into a run recording under
# an ordinary name would pass this and still breach the rule. So this is
# a floor and not a licence: the judgement at commit time is still the
# thing that matters, and "if in doubt, it does not come here" still
# governs. A guard that made anyone relax would be worse than none.

set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

if [[ "${1:-}" == "--staged" ]]; then
  mapfile -t files < <(git diff --cached --name-only --diff-filter=ACMR)
  what="staged for commit"
else
  mapfile -t files < <(git ls-files)
  what="tracked"
fi

if [[ ${#files[@]} -eq 0 ]]; then
  echo "nothing $what"
  exit 0
fi

# The extensions kettle's .gitignore reserves, case-insensitively, plus
# the bare `.private` form. Matched on the whole path, because the name
# can be anywhere in it.
offenders=()
for f in "${files[@]}"; do
  if [[ "${f,,}" == *".private."* || "${f,,}" == *".private" ]]; then
    offenders+=("$f")
  fi
done

if [[ ${#offenders[@]} -gt 0 ]]; then
  echo "REFUSED: these are named as real documents and this repository is public:" >&2
  printf '  %s\n' "${offenders[@]}" >&2
  echo >&2
  echo "kettle reserves *.private.<ext> for a person's own papers. Nothing" >&2
  echo "derived from one may enter an archive — not the file, not an OCR of" >&2
  echo "it, not a run that read it. See README.md." >&2
  exit 1
fi

# A directory with no MANIFEST is not yet a recording: nobody can say
# what it measured, so nobody can say it was a bed run either.
missing=()
while IFS= read -r entry; do
  [[ -z "$entry" ]] && continue
  [[ -f "$entry/MANIFEST.md" ]] || missing+=("$entry")
done < <(printf '%s\n' "${files[@]}" | awk -F/ 'NF>1 && $1 !~ /^\./ && $1 != "scripts" {print $1}' | sort -u)

if [[ ${#missing[@]} -gt 0 ]]; then
  echo "REFUSED: these entries carry no MANIFEST.md:" >&2
  printf '  %s\n' "${missing[@]}" >&2
  echo >&2
  echo "An entry that cannot say what it measured cannot say it was a bed" >&2
  echo "run. Name the pack, model, set, scoring version, bed digest," >&2
  echo "sidecar, machine and what it backs." >&2
  exit 1
fi

echo "boundary ok — ${#files[@]} files $what, none named as a real document, every entry manifested"
