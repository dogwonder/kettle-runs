# 2026-08-24 — subscription pack, Qwen3.8-27B (**ggml-org build**), scoring v15, on a rented RTX 4090

A **control run**. Its only job is to isolate one variable, and it does.

- **Pack**: app.kttl.subscription-audit v1.5.0
- **Model**: qwen3.8-27b-ggmlorg-q4_k_m.gguf (27B, Q4_K_M, context 8192)
  — `ggml-org/Qwen3.8-27B-GGUF`, file `Qwen3.8-27B-Q4_K_M.gguf`.
  Verified on the pod: 18,973,870,432 bytes, SHA-256
  `31629f53165ab6a7dad8c9847dcfd1fdf55829dac1e6e748f4a68581b0033d34`.
  **This is the build the 21 August audition used**, per notes on #539 —
  which is the whole reason this run exists.
- **Eval set**: development, 84 fixtures, **1 run**
- **Scoring version**: 15
- **Bed digest**: `blake3:f3512515b617df26e920f749ac342ee10e649fc10593277ff70fbdbd93c68f35`
  — same bed as the 4B, 9B and bartowski-27B entries.
- **Sidecar**: llama-server 10145 (ad256ded), **CUDA0 (NVIDIA GeForce RTX 4090)**,
  `KETTLE_CUDA_ARCH=89`
- **Runtime**: context 8192, parallel 1, **reasoning off**, max answer tokens 4096
- **Machine**: **rented** — AMD Ryzen 9 7950X 16-core, 125GB RAM,
  Ubuntu 24.04.3 LTS, RTX 4090, RunPod (pod `2s4vq1jnujnlu5`)
- **Kettle commit**: `7c257c5d3fc6f44b3265ecc7e6e304a3f389e761`, clean tree
- **Recorded**: 2026-08-24, 32m21s
- **Verdict**: **FAIL**
- **Backs**: the confound analysis in
  `2026-08-24-subscription-qwen3.8-27b-v15-runs3-pod4090/MANIFEST.md`.

## Why one pass and not three

`--runs 1` is deliberate. This run is not a claim-backing baseline; it
exists to answer a single question — *does the 27B build explain the
difference* — and three passes would have bought nothing, determinism
having already reported byte-identical records on three separate
`--runs 3` runs on this bed.

## The question this settles

The remembered subscription scale curve had confident-wrong rising
0.00 → 0.27 → 0.46 across 4B → 9B → 27B. The full bed at scoring 15
reads flat: 0.03 → 0.05 → 0.05. **Three things differed** between those
two measurements — a 7-fixture audition subset vs the 84-fixture bed,
scoring 14 vs 15, and the ggml-org build vs bartowski's.

This run holds bed, scoring and machine fixed and changes only the build.

```
model                            normalise (pooled)              e2e   review  time    verdict
qwen3.8-27b-q4_k_m.gguf          0.79 (n=900; CI 0.76–0.81)      1.00  37%     30m22s  FAIL   (bartowski)
qwen3.8-27b-ggmlorg-q4_k_m.gguf  0.79 (n=900; CI 0.76–0.82)      1.00  38%     32m21s  FAIL   (ggml-org)
```

| | bartowski | ggml-org |
|---|---|---|
| normalise (pooled, n=900) | 0.79 | 0.79 |
| end-to-end | 1.00 | 1.00 |
| harm / subscription precision | 1.00 (n=329) | 1.00 (n=329) |
| harm / subscription recall | 0.95 (n=488) | 0.96 (n=488) |
| gate any-statement / subscription | 0.12 (n=32) | 0.12 (n=32) |
| gate any-statement / not_subscription | 0.00 (n=60) | 0.00 (n=60) |
| confidence `high` error | 0.06 (n=77) | 0.08 (n=78) |
| confidence `medium` error | 0.35 (n=31) | 0.33 (n=24) |
| untraceable decisions | 44 | 45 |
| guardrail escapes (schema/pairing) | 148 | 157 |

**The build is not the cause.** Every gate with a usable denominator
reports the same number to two decimal places. The remaining candidates
for the vanished rise are the audition subset and the scoring version —
and of those the subset is much the likelier, the full bed having
already been found to disagree with the audition about which path the
harm arrives by.

The one visible difference is `free-trial-conversion`, 0.25 against
0.38. Both are n=8 with intervals spanning 0.07–0.59 and 0.14–0.69.
That is noise, and it is quoted here only so nobody later reads it as a
build difference.

## A second thing this measures, for free

Two independent quantisations of the same weights, by different
quantisers, ~1.1GB apart in file size, produce the same scores on this
bed. Quantiser choice at Q4_K_M does not move this measurement — one
bed, one model, so not a general law, but a useful fact about how much
the instrument depends on where the GGUF came from.
