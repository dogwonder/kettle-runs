# 2026-08-24 — subscription pack, Qwen3.8-27B, scoring v15, `--runs 3`, on a rented RTX 4090

- **Pack**: app.kttl.subscription-audit v1.5.0
- **Model**: qwen3.8-27b-q4_k_m.gguf (27B, Q4_K_M, context 8192)
  — **not** in `app/src-tauri/models.json`. Source repository
  `bartowski/Qwen3.8-27B-GGUF`, file `Qwen3.8-27B-Q4_K_M.gguf`. Note the
  id has no `Qwen_` prefix, unlike the 3.5 repositories.
  Verified on the pod after download: 17,772,537,440 bytes, SHA-256
  `e103abf9d914d1d7b2f2592f055f2759a71195c350a01c135f71aaae86bca52b`,
  matching the repository's LFS object id.
- **Eval set**: development, 84 fixtures, **3 runs**
- **Scoring version**: 15
- **Bed digest**: `blake3:f3512515b617df26e920f749ac342ee10e649fc10593277ff70fbdbd93c68f35`
  — **the same bed** as the 9B entry of the same date and the 4B entry of
  23 August, so all three are directly comparable.
- **Sidecar**: llama-server 10145 (ad256ded), **CUDA0 (NVIDIA GeForce RTX 4090)**,
  built on the pod from the pinned tag with `KETTLE_CUDA_ARCH=89`
- **Runtime**: context 8192, parallel 1, **reasoning off**, max answer tokens 4096
- **Machine**: **rented** — AMD Ryzen 9 7950X 16-core, 125GB RAM,
  Ubuntu 24.04.3 LTS, RTX 4090, RunPod (pod `2s4vq1jnujnlu5`)
- **Kettle commit**: `7c257c5d3fc6f44b3265ecc7e6e304a3f389e761`, clean tree
- **Recorded**: 2026-08-24, 30m22s per pass (~91 min for three)
- **Verdict**: **FAIL**
- **Backs**: no committed baseline. A **model audition recording** for the
  lab (M8), and the third point of the first scale comparison Kettle has
  where every point carries a recording.

## Why this run was taken

To complete the pair started by the 9B entry of the same date. The 27B's
earlier showing on this pack existed only as session numbers, with no
recording of which file produced them — so it could not be replayed,
cited, or checked.

**It is not a reproduction of that earlier number and must not be read as
one.** No recording of the earlier audition exists, so which 27B build it
used is unknown. This is a new measurement with a named digest.

Quantisation was chosen to keep the comparison clean: the 4B and 9B are
bartowski *plain* Q4_K_M, so a 27B in unsloth's UD or AtomicChat's AD
dynamic quantisation would have confounded model scale with quantisation
recipe. `bartowski/Qwen3.8-27B-GGUF` is the same quantiser and the same
recipe.

## The verdict

```
app.kttl.subscription-audit v1.5.0 · development set · 84 fixtures · 3 runs · RTX 4090

model                    normalise (pooled)              e2e (mean)  review (mean)  time    verdict
qwen3.8-27b-q4_k_m.gguf  0.79 (n=900; 95% CI 0.76–0.81)  1.00        37%            30m22s  FAIL

gate / any-statement / subscription       confident-wrong 0.12 (n=32; CI 0.05–0.28) <= 0.05  UNPROVEN (needs 73)
gate / any-statement / not_subscription   confident-wrong 0.00 (n=60; CI 0.00–0.06) <= 0.05  UNPROVEN (needs 73)
gate / annual-subscription-once-yearly    confident-wrong 0.00 (n=8;  CI 0.00–0.32) <= 0.05  UNPROVEN (needs 73)
gate / free-trial-conversion              confident-wrong 0.25 (n=8;  CI 0.07–0.59) <= 0.05  UNPROVEN (needs 73)
gate / price-rise-mid-series              confident-wrong 0.00 (n=8;  CI 0.00–0.32) <= 0.05  UNPROVEN (needs 73)

classification / overall / harm / subscription      precision 1.00 (n=329); recall 0.95 (n=488); confident-wrong 0.05
classification / overall / harm / not_subscription  precision 0.90 (n=261); recall 1.00 (n=411)

confidence  high 0.06 (n=77) · medium 0.35 (n=31) · low 15 decisions, all routed · untraceable 44
claim guardrail  schema 148 escaped · pairing 148 escaped · review_routing 309 contained, 0 escaped
```

## The scale curve, on one bed

Every row below is bed digest `f3512515…`, scoring 15, reasoning off,
plain Q4_K_M, development set, 84 fixtures.

| | 4B (23 Aug, M1 Pro) | 9B (24 Aug, 4090) | 27B (24 Aug, 4090) |
|---|---|---|---|
| normalise (pooled, n=900) | 0.69 | 0.76 | **0.79** |
| end-to-end | 1.00 | 1.00 | 1.00 |
| review rate | 39% | 36% | 37% |
| harm / subscription confident-wrong (n=488) | 0.03 | 0.05 | 0.05 |
| confidence, `high` error | 0.10 (n=49) | 0.14 (n=73) | **0.06 (n=77)** |
| confidence, `medium` error | 0.50 (n=12) | 0.86 (n=28) | **0.35 (n=31)** |
| untraceable decisions | 67 | 57 | 44 |
| verdict | FAIL | FAIL | FAIL |

**Three findings, and the second is the one that changes something.**

**Scale does not clear the threshold.** normalise climbs 0.69 → 0.76 →
0.79 against a bar of 0.85, with end-to-end pinned at 1.00 throughout.
Roughly seven times the parameters buys 0.10 and does not arrive. The
honest reading is that this threshold is not reachable by model choice,
so it is a fact about the pack, the prompt or the metric — not about the
model. A negative result, and a load-bearing one for anyone deciding
what to run.

**The "scale pays in denial" claim does not survive.** It was remembered
as confident-wrong rising 0.00 → 0.27 → 0.46 across 4B → 9B → 27B. On
this bed, with recordings behind every point, harm/subscription
confident-wrong reads **0.03 → 0.05 → 0.05** — flat, not rising. The
pooled gate moves 0.16 (9B) → 0.12 (27B), i.e. *down*. The remembered
figures came from unarchived auditions on some other subset and should
not be quoted again. This is exactly what archiving buys: a claim that
rested on nothing is now checkable, and it did not check out.

**Calibration is where scale actually paid.** The 27B's `medium` band
errs at 0.35 against the 9B's 0.86, its `high` band at 0.06 against
0.14, and it leaves 44 decisions untraceable against 57. On a pack where
confidence ranks at all (#429 found it gives no signal on letters), that
is the clearest separation the three models show.

Caveat on the per-stratum cells: `free-trial-conversion` moves 0.12 →
0.25 and `annual-subscription-once-yearly` 0.25 → 0.00 between the 9B
and the 27B. Both are n=8 with confidence intervals spanning most of the
unit interval. They are noise and are quoted here only so nobody reads
them as signal later.

## The three runs agreed on everything

All 84 fixtures reported an identical low and high on every step score,
end-to-end score and review rate, with **a single record digest each** —
the three passes produced byte-identical records.

Not a cache artefact: 30m22s a pass against ~91 minutes of wall clock is
three full passes of GPU work.

## What is in this entry

`run1/`, `run2/` and `run3/` — all three passes, matching the 9B entry
of the same date.

`pod-baseline-subs-27b.json` is the baseline this run wrote. It is **not**
a committed kettle baseline and must not become one: the verdict is FAIL,
and the timing is a rented 4090's, never a `tiers.json` entry.

## Note on the guardrail escapes

`schema` and `pairing` report 148 escaped and 0 contained. This is not
new to the 27B — the 9B reports 353 and the 4B 153 on the same bed. Those
two guardrails have no purchase on this pack, which is #432's open
containment question rather than a regression here. The 27B escapes
least of the three.
