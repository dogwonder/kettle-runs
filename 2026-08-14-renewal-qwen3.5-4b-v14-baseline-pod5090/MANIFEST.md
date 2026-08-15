# 2026-08-14 — renewal pack, Qwen3.5-4B, scoring v14, the adopted baseline

- **Pack**: app.kttl.renewal-diff 0.1.0
- **Model**: qwen3.5-4b-q4_k_m.gguf (4B, Q4_K_M, context 8192)
- **Eval set**: development, 62 fixtures
- **Scoring version**: 14
- **Bed digest**: `blake3:5b52918ea896ba09d28b5e253043ffe85953e802fafb3fd9424138760e0d670e`
- **Sidecar**: llama-server 10145 (ad256ded), CUDA, built on the pod;
  device `CUDA0 (NVIDIA GeForce RTX 5090) (0000:ca:00.0)`
- **Machine**: **rented** — RunPod, NVIDIA RTX 5090, Linux x86_64, 64 cores
- **Recorded**: 2026-08-14, stamped 16:18:01Z; 4m11s wall clock
- **Backs**: `evals/baseline-v14-renewal.json`, adopted as this pack's
  prompt-edit floor, and the assurance claim
  `renewal-development-verdict`, which this run returned to **proven**
  after three days unproven on v13 evidence.

## The result

```
qwen3.5-4b-q4_k_m.gguf  0.98 (n=362; 95% CI 0.96–0.99)  e2e 0.96  review 1%  4m11s  PASS

gate / any-schedule / obligation     0.00 (n=322)  PASS
gate / any-schedule / no_obligation  0.02 (n=385)  PASS
relations                            5 held, 0 failed, 1 unjudgeable
containment                          1132 candidates, 11 contained, 8 escaped
```

Seven guardrails ran. That number is why this entry is worth reading
beside its letter sibling from the same afternoon, which ran three.

## What it also carries: the confidence table

```
confidence / high: 342 decisions;  8 wrong; 11 routed;  error 0.02 (n=331 asserted)
confidence / low:  339 decisions;  0 wrong;  0 routed;  error 0.00 (n=339 asserted)
confidence / untraceable: 30
INVERTED — `high` is measurably more wrong than `low` (1 further error would withdraw it)
```

**This inversion is real, and it is the only one of the three packs
where it survived scrutiny.** The `low` bucket routed *nothing* — all
339 of its decisions were asserted — so a 0.00 error rate there is
earned rather than guaranteed. Contrast the subscription entry, where a
wholly routed bucket produced a false inversion and exposed a defect in
the scorer.

What it means for the product: routing this pack's low-confidence
decisions to review would spend the review on the decisions least
likely to need it. Read it with `withdrawn_by: 1` — one further error
in `low` ends the separation, which is 0.0007 wide.

## Provenance note

Recorded on the second rented sitting of 14 August, after the morning's
exit-run findings had been fixed and merged. Its v13 predecessor is at
`2026-08-14-renewal-qwen3.5-4b-v14-pod5090` — same day, different tree,
and the one whose numbers the registry no longer stands on.
