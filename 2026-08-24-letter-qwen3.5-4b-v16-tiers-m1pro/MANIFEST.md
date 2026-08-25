# 2026-08-24 — letter pack, Qwen3.5-4B, scoring v16, on the M1 Pro

- **Pack**: app.kttl.letter-to-actions v0.2.0
- **Model**: qwen3.5-4b-q4_k_m.gguf (4B, Q4_K_M, context 8192)
- **Eval set**: development, 413 fixtures, 1 run
- **Scoring version**: 16
- **Bed digest**: `blake3:57b37e87570cc6612fbaa96c1e633e2382b5ea2dedbf997a6d83a0c89df4826a`
- **Sidecar**: llama-server 10145 (ad256ded3), Metal (MTL0), bundled in `sidecars/macos-arm64/`
- **Runtime**: context 8192, parallel 1, **reasoning off**, max answer tokens 4096
- **Machine**: **local** — Apple M1 Pro, 32GB, macOS 26.5.2
- **Recorded**: 2026-08-24, measured_at 2026-08-24T17:33:25Z
- **Verdict**: **PASS** (end-to-end 1.00, automatic 0.89; obligation
  precision and recall 1.00 over 509 decisions, confident-wrong 0.00
  with a Wilson upper bound of 0.0075)
- **Backs**: the v16 entry in `packs/app.kttl.letter-to-actions/tiers.json`
  (kettle commit `7dca874`, PR #561).

## Why this run is archived

kettle's CLAUDE.md holds that a run backing a committed baseline, tier
or cited finding is archived before cleanup. This run backs the letter
pack's v16 tiers entry, which was committed with PR #561 without the
recording following it here. Its sibling — the same sitting's
subscription re-measure, archived as
`2026-08-24-subscription-qwen3.5-4b-v16-tiers-m1pro` — had the same
gap, and both are corrected together.

It exists at all because SCORING_VERSION 15 → 16 (#561, a ceiling the
bed can disprove now fails instead of reading UNPROVEN) invalidated
every v15 tiers entry: a tier is a statement about what a model can be
trusted to do at a scoring version, so a bump costs a real re-measure
rather than a replay.

## Reading it beside the v15 run

`2026-08-23-letter-qwen3.5-4b-v15-tiers-m1pro` is the same bed digest,
weights, sidecar and machine one day earlier. The **score** comparison
between the two is meaningful and is what the v16 bump was measured on.
The **timing** comparison is not evidence of anything: per PR #562 and
`app/DECISIONS.md` (#220, amended 25 August 2026), wall time, model
time, token rate and peak memory are sitting-local telemetry and no
longer enter tiers, baselines, score cards or gates. The per-fixture
`run.json` receipts in `run1/` still carry that telemetry for
diagnosis; nothing committed in kettle does.
