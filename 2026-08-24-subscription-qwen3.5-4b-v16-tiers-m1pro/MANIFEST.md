# 2026-08-24 — subscription pack, Qwen3.5-4B, scoring v16, on the M1 Pro

- **Pack**: app.kttl.subscription-audit v1.5.0
- **Model**: qwen3.5-4b-q4_k_m.gguf (4B, Q4_K_M, context 8192)
- **Eval set**: development, 84 fixtures, 1 run
- **Scoring version**: 16
- **Bed digest**: `blake3:f3512515b617df26e920f749ac342ee10e649fc10593277ff70fbdbd93c68f35`
- **Sidecar**: llama-server 10145 (ad256ded3), Metal (MTL0), bundled in `sidecars/macos-arm64/`
- **Runtime**: context 8192, parallel 1, **reasoning off**, max answer tokens 4096
- **Machine**: **local** — Apple M1 Pro, 32GB, macOS 26.5.2
- **Recorded**: 2026-08-24, measured_at 2026-08-24T19:21:04Z
- **Verdict**: **FAIL** (normalise 0.00 over 10, end-to-end 1.00 — the
  same shape-bound failure as the 23 August v15 run, re-measured because
  SCORING_VERSION 16 (#561) invalidated the v15 tiers entry)
- **Backs**: the v16 entry in `packs/app.kttl.subscription-audit/tiers.json`
  (kettle commit `7dca874`, PR #561), and the cited observation in
  `app/DECISIONS.md` (#220, amended 25 August 2026) and
  `evals/README.md` that byte-identical answers on the same machine
  took 190,772ms on 23 August and 2,162,257ms on 24 August. That pair
  is why wall time left tiers, baselines and score cards.

## Why this run is archived

Two reasons, and the second is the one that made it urgent.

The tiers entry it backs was committed without archiving the run — the
rule in kettle's CLAUDE.md says a run backing a committed tier is
archived before cleanup, and this one was not. That is corrected here.

Then PR #562 cited its wall clock as the motivating observation for
retiring resource metrics as evidence, while deleting the value from
`tiers.json`. A finding cited in a decision has to be re-askable, and
the only receipt of this sitting's 2,162,257ms was a gitignored local
run directory. The per-fixture `run.json` receipts in `run1/` keep the
telemetry; the tiers file no longer does, by design.

Same bed digest, weights, sidecar and machine as
`2026-08-23-subscription-qwen3.5-4b-v15-tiers-m1pro`: the score
comparison between the two is meaningful, the timing comparison is the
point — that it is not.
