# 2026-08-25 — letter pack, Qwen3.5-4B, scoring v16, **pod run** (RTX 3090)

- **Pack**: app.kttl.letter-to-actions v0.2.0
- **Model**: qwen3.5-4b-q4_k_m.gguf (4B, Q4_K_M, context 8192),
  sha256 `13c16f426047e2de38cd075bdade4a7bcbc8c774384876f677740cda65f8a983`
- **Eval set**: development, 413 fixtures, 1 run
- **Scoring version**: 16
- **Bed digest**: `blake3:57b37e87570cc6612fbaa96c1e633e2382b5ea2dedbf997a6d83a0c89df4826a`
- **Sidecar**: llama-server 10145 (ad256ded), **CUDA0 (NVIDIA GeForce RTX 3090)**,
  built on the pod from the pinned tag with `CMAKE_CUDA_ARCHITECTURES=86`
- **Runtime**: context 8192, parallel 1, **reasoning off**, max answer tokens 4096
- **Machine**: **rented pod** — RunPod, 1× RTX 3090 24GB, AMD EPYC 7C13
  64-core, 1008GB RAM, Ubuntu 24.04.3 LTS
- **Commit**: kettle `e29948d`, clean tree, no hand-applied patches
- **Recorded**: 2026-08-25, measured_at 2026-08-25T09:05:02Z
- **Verdict**: **PASS**. Obligation 0.00 confident-wrong over 240
  decisions against a 0.02 ceiling; no_obligation 0.00 over 101 against
  0.05; pooled obligations 1.00 (n=509); end-to-end 1.00; review 0%;
  containment 1 decision surfaced of 4,036 candidates with 0 wrong
  assertions escaped; relations 14 held, 0 failed, 1 unjudgeable.
- **Backs**: `evals/baseline-v16-letter.json` and the
  `letter-harm-ceilings` claim in `assurance/claims.json`.

## Why this run exists

SCORING_VERSION 15 → 16 (#561) is a declared invalidation trigger. The
24 August sitting re-measured the pack's `tiers.json` entry at v16 but
not the baseline the registry cites, so `kettle claims` read
`letter-harm-ceilings` as unproven (recorded proven) from that merge
until this recording. `--write-baseline` is refused with `--replay`, so
re-scoring the v15 recording was not available and a real run was.

`--runs 1`, unlike the v15 recording's `--runs 3`. v16 changed how a
verdict is *derived* from answers, not the answers; stability on this
bed and these weights was established by the 24 August `--runs 3` run
archived as `2026-08-24-letter-qwen3.5-4b-v15-runs3-pod3090`.

## What it measures beyond the pack

**Backend score equivalence, now at a second scoring version.** The same
commit, bed digest and weights ran on the M1 Pro at v16 the day before —
`2026-08-24-letter-qwen3.5-4b-v16-tiers-m1pro` (Metal). The two agree
exactly: obligation precision and recall 1.00 over 509 decisions on
both, no_obligation over 938 and 939, confident-wrong 0.00 throughout.
At v15 the same comparison held across all 56 extraction strata
(23 August Metal against 24 August CUDA). So `evals/RENTED-GPU.md`'s
equivalence is measured at two consecutive scoring versions rather than
asserted. One pack on one bed; not a general law.

**The timings are not part of that.** Wall time is sitting-local
telemetry as of #562 — it stays in the per-fixture `run.json` receipts
here, where it can diagnose this sitting, and enters no tier, baseline,
score card, gate or duration promise.

## What the run does not establish

The confidence signal is absent on this pack: all 476 decisions came
back `high`, so routing by it separates nothing (#429, #519). And this
is the **development** set only — the exam set's invoice shape answers
the same prose very differently, which is #552.
