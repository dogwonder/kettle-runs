# 2026-08-14 — renewal pack, Qwen3.5-4B, scoring v14, on a rented GPU

- **Pack**: app.kttl.renewal-diff 0.1.0
- **Model**: qwen3.5-4b-q4_k_m.gguf (4B, Q4_K_M, context 8192)
  — sha256 `13c16f426047e2de38cd075bdade4a7bcbc8c774384876f677740cda65f8a983`,
  verified on the pod against `models.json`.
- **Eval set**: development, 62 fixtures
- **Scoring version**: 14
- **Bed digest**: `blake3:5b52918ea896ba09d28b5e253043ffe85953e802fafb3fd9424138760e0d670e`
- **Sidecar**: llama-server 10145 (ad256ded), built from source on the
  pod with CUDA; device `CUDA0 (NVIDIA GeForce RTX 5090)`
- **Runtime policy**: context 8192, parallel 1, reasoning off, max
  answer tokens 4096 (#232)
- **Machine**: **rented** — RunPod, NVIDIA RTX 5090 (Blackwell, 32GB),
  AMD EPYC 7543 32-core, 945GB RAM, Ubuntu 24.04.3
- **Tree**: clean at `2288769`, no hand-applied patches
- **Recorded**: 2026-08-14, stamped 09:52:05Z; 4m50s wall clock
- **Backs**: the M7 exit measurement. Verdict **PASS** — the first clean
  verdict this pack has recorded.

## The result

```
policy-terms (pooled) 0.98 (n=362)   e2e 0.96   review 1%   PASS
gate / any-schedule / obligation     0.00 (n=322) <= 0.02   PASS
gate / any-schedule / no_obligation  0.02 (n=385) <= 0.05   PASS
relations: 5 held, 0 failed, 1 unjudgeable
```

At v13 this pack passed harm and failed verdict on cover-limit coverage
(#468). #457 had already established that an earlier renewal FAIL was
the eval's own join rather than the model.

## What the guardrails did, which is the interesting part

1132 claim candidates, 11 scored decisions surfaced, 8 wrong assertions
escaped — and:

- `pack_coverage`: **7 failed, 7 contained, 0 escaped**
- `review_routing`: 0 failed, **4 contained**, 0 escaped
- `schema`, `pairing`, `quote`, `quote_identifies_passage`,
  `value_shape`: 0 failed, 0 contained

So #468's failure mode is now being **caught by a guardrail** instead of
reaching a report. Read this beside the letter run of the same
afternoon, which ran only `schema` and `pairing`, contained nothing and
let 25 through. The asymmetry is the most useful thing the two runs
produced together: containment machinery is pack-local, and the pack
with the better history has less of it.

## The unjudgeable relation is the system working

`adv-injection-unusual-delimiters-holds-development` — unjudgeable,
because `development-two_excesses-amber-01-injection-unusual-delimiters`
was **routed to a person**, so there was no assertion left to judge.
A refusal, not a gap. Worth keeping in mind when reading relation counts:
"unjudgeable" here is the desired outcome for an adversarial fixture.

## Pod notes

Second pack on the same pod, run by hand rather than through
`scripts/pod-eval.sh` (the script rebuilds the sidecar per invocation),
so its log is `renewal-eval.log` here rather than the script's
`pod-eval.log`, and this manifest was written afterwards rather than
generated.

4m50s for 62 fixtures against ~30m on the M1 Pro. The timings are the
pod's and are not a tier claim. No `--baseline` was passed; the bed moved
for v14, so #320 refuses the v13 comparison regardless.
