# kettle-runs

Raw eval run recordings backing [kettle](https://github.com/dogwonder/kettle)'s
committed baselines. A baseline records what the numbers were; these
recordings are what let the numbers be **re-asked** — replayed under a
new scoring version, fed to the mutation harness, rescored for an
ablation — without re-running hours of GPU. #457 was settled exactly
that way: unchanged recorded answers, replayed under new scoring.

## Rules

- **Retention, not hoarding.** A run is archived here if a committed
  baseline or a cited finding stands on it. Scratch runs
  (`--fixture-dir` loops, aborted runs) are disposable and never enter.
- **Bed runs only — the privacy hard line**, and since 19 August 2026
  there is a mechanism as well as a sentence. `scripts/check-boundary.sh`
  refuses any path named `*.private.*` and any entry with no MANIFEST,
  and `.githooks/pre-commit` runs it on what you are about to commit
  (`git config core.hooksPath .githooks`, once per clone). It catches
  the file-shaped mistake — the directory dragged across without being
  looked at. It cannot read content, so a real letter OCR'd into a
  recording under an ordinary name would pass it. **A floor, not a
  licence**: this repository is public, deleting a file does not unclone
  it, and "if in doubt, it does not come here" still governs. Every recording here is
  from wholly synthetic fixtures. Nothing from a real document may
  ever enter this repo: `*.private` inputs, field-evidence runs (#428)
  and anything OCR'd or transcribed from a person's papers live under
  kettle's deletion boundary, and an archive is exactly where that
  boundary would be violated by accident. If in doubt, it does not
  come here.
- **Immutable.** Entries are never edited after their commit — a
  recording that changed would be worse than one that was lost. A
  correction is a new entry.
- **Self-describing.** Each entry carries a `MANIFEST.md` naming pack,
  model, eval set, scoring version, bed digest, sidecar, machine, and
  the baseline or issue it backs (kettle's #303 rule: a recording must
  describe itself). Per-recording provenance lives inside the
  recordings themselves.

## Layout

```
<date>-<what>/
  MANIFEST.md
  run1/        # the run directory, verbatim
  resume/      # where an entry includes interrupted-run records
```

## Relation to kettle #477

If kettle opens a public evidence layer, this repo is its natural
seed: synthetic by construction, and together with the committed
baselines it lets anyone verify scoring without weights or a GPU.
