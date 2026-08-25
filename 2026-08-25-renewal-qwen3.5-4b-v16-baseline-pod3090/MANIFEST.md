# 2026-08-25 — renewal pack, Qwen3.5-4B, scoring v16, **pod run** (RTX 3090)

- **Pack**: app.kttl.renewal-diff v0.1.0
- **Model**: qwen3.5-4b-q4_k_m.gguf (4B, Q4_K_M, context 8192),
  sha256 `13c16f426047e2de38cd075bdade4a7bcbc8c774384876f677740cda65f8a983`
- **Eval set**: development, 62 fixtures, 1 run
- **Scoring version**: 16
- **Bed digest**: `blake3:5b52918ea896ba09d28b5e253043ffe85953e802fafb3fd9424138760e0d670e`
- **Sidecar**: llama-server 10145 (ad256ded), **CUDA0 (NVIDIA GeForce RTX 3090)**,
  built on the pod from the pinned tag with `CMAKE_CUDA_ARCHITECTURES=86`
- **Runtime**: context 8192, parallel 1, **reasoning off**, max answer tokens 4096
- **Machine**: **rented pod** — RunPod, 1× RTX 3090 24GB, AMD EPYC 7C13
  64-core, 1008GB RAM, Ubuntu 24.04.3 LTS
- **Commit**: kettle `e29948d`, clean tree, no hand-applied patches
- **Recorded**: 2026-08-25, measured_at 2026-08-25T08:51:34Z
- **Verdict**: **PASS**. Obligation 0.00 confident-wrong over 322
  decisions against a 0.02 ceiling; no_obligation 0.02 over 385 against
  0.05; relations 5 held, 0 failed, 1 unjudgeable.
- **Backs**: `evals/baseline-v16-renewal.json` and the
  `renewal-development-verdict` claim in `assurance/claims.json`.

## Why this run exists

The same reason as its letter sibling: SCORING_VERSION 15 → 16 (#561)
invalidated the v15 baseline the registry cites, `--write-baseline` is
refused with `--replay`, and the claim read unproven until this
recording.

`--runs 1` rather than the v15 recording's `--runs 3`, for the same
reason — a scoring-only bump does not re-open a question about the
answers, and the 24 August `--runs 3` run
(`2026-08-24-renewal-qwen3.5-4b-v15-runs3-m1pro`) had all 62 fixtures
agreeing across three runs on every step score, end-to-end score and
review rate.

## The sidecar string moved again, the other way

This recording prints `10145 (ad256ded)` where the 24 August Metal one
printed `10145 (ad256ded3)` — the same llama.cpp build with one fewer
character of its hash. The exact-match content check (#489) reads that
as a change, so the claim's `recorded_against.sidecar` was updated to
match. Noted here for the same reason the v15 recording noted it in the
opposite direction: so the next reader does not take it for a real
difference.

## What the run does not establish, and should not be read as

**8 wrong assertions escaped, every one in the `excess-unqualified`
stratum**, which reads confident-wrong 1.00 over 8. None of the five
claim guardrails — schema, pairing, quote, quote_identifies_passage,
value_shape — contained any of them. That is the label-ambiguity class
#432 found no quote rule can catch; it is unchanged by v16 and sits
outside the gate because those decisions do not join it.

The confidence signal remains **INVERTED** on this pack: `high` errs
0.02 over 337 decisions where `low` errs 0.00 over 325, so routing the
less confident decisions to review spends the review on the wrong ones
(#429). One further error in `low` would withdraw that reading.

Neither property is asserted by the claim this run backs.

**Backend equivalence has never been measured on this bed** — only on
the letter development bed, at v15 and v16. A future prompt edit judged
solely by comparing a Metal run against this CUDA baseline is worth a
second thought. Timings are sitting-local telemetry (#562) and enter
nothing.
