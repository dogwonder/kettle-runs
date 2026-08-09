# 2026-08-09 — main checkout's accumulated recordings, v11–v13 era

Snapshot of the main checkout's `evals/runs/run1` and `evals/resume`
as of 9 August 2026. Unlike the sibling entry, this is an
**accumulation**, not a single run: recordings are keyed by question
(kettle #328), so successive measurements reused and extended this
directory. Per-recording provenance is inside each recording; this
manifest records the population:

| Pack + model | Recordings |
|---|---|
| letter-to-actions, gemma-4-E4B-it-Q4_K_M | 366 |
| letter-to-actions, no-model floor | 366 |
| letter-to-actions, qwen3.5-4b-q4_k_m | 366 |
| letter-to-actions, qwen3.5-9b-q4_k_m | 355 (pre-#456 bed) |
| renewal-diff, no-model floor | 53 |
| renewal-diff, qwen3.5-4b-q4_k_m | 53 |

- **Backs**: `evals/baseline-v11-letter.json`,
  `evals/baseline-v12-letter.json`, `evals/baseline-v12-renewal.json`
  and `evals/baseline-v13-renewal.json` (renewal recorded
  2026-08-09T10:23:09Z, bed
  blake3:c438a0df2d88b84e0b29a5eab912a2ded1acc5d60d6fcfa1f6666faa8c429d3d,
  sidecar 10145) — plus the resume records that diagnosed #435 (the
  445 expected/actual pairs) and the replay verification of #457.
- **Caveat**: because this is an accumulation, attributing an
  individual recording to a specific measurement requires its own
  internal provenance — do not assume membership in a baseline from
  presence in this snapshot.
