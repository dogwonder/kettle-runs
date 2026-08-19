# 2026-08-19 — renewal pack, Qwen3.5-4B, scoring v14, three runs

- **Pack**: app.kttl.renewal-diff v0.1.0
- **Model**: qwen3.5-4b-q4_k_m.gguf (4B, Q4_K_M, context 8192, reasoning off)
- **Eval set**: development, 62 fixtures, **3 runs**
- **Scoring version**: 14
- **Bed digest**: `blake3:5b52918ea896ba09d28b5e253043ffe85953e802fafb3fd9424138760e0d670e`
- **Sidecar**: llama-server 10145 (ad256ded), CUDA0
- **Machine**: **rented** — RunPod, RTX 5090, Linux x86_64, 32 cores
- **Commit**: `bc3cc9d` (superseded by `5c8611a`, squashed to main as `84222c6`)
- **Recorded**: 2026-08-19, 3m51s per repeat
- **Verdict**: **PASS**, and **zero spread**
- **Backs**: `evals/baseline-v14-renewal.json` and the assurance claim
  `renewal-development-verdict`, whose `invalidation` now names
  "repeats disagreeing".

## Why this run was taken

The other half of #533, run the same afternoon and the same way as
`2026-08-19-letter-qwen3.5-4b-v14-runs3-pod5090`. Neither live claim now
stands on a single run.

`evals/RENTED-GPU.md` says a ~30m local run is not worth renting a box
for, and that is about provisioning — which was already sunk and warm.
Eight further minutes for the second half of the issue was the easiest
call of the session.

## The result

```
app.kttl.renewal-diff v0.1.0 · development set · 62 fixtures · 3 runs · RTX 5090

model                   policy-terms (pooled)           e2e   review  time    verdict
qwen3.5-4b-q4_k_m.gguf  0.98 (n=362; 95% CI 0.96–0.99)  0.96  1%      3m51s   PASS

gate / any-schedule / obligation  0.00 (n=322) <= 0.02  PASS
relations  none failed
confidence  high 0.02 (n=331), low 0.00 (n=339, none routed)

stability  62 of 62 fixtures carry a Stability block at runs: 3
           NOTHING MOVED — every step score, end-to-end score and
           review rate reports an identical low and high
```

## Same provenance, one exception

Same bed digest and same sidecar **version** as the 14 August file this
replaces, so this is the same measurement asked three times rather than
a different one. The only provenance that differs is the GPU's PCI bus
address — `0000:ca:00.0` then, `0000:02:00.0` now — being a different
rented box of the same model. Validation compares the sidecar version
and is unaffected.

It carries the same `ae297db` correction the letter baseline did: the
old file counted all 342 decisions in the confidence bucket's
denominator where the 11 routed ones are now excluded, so every run
since reads n=331.

## What is in here

`run1/`, `run2/`, `run3/` — 62 fixture directories each, `raw/` holding
the rendered request and the model's answer verbatim. The letter run
earlier that day wrote into the same `evals/runs/run*` directories on
the pod, so this entry was split out by pack id rather than archived as
the mixed tarball it arrived in — a tarball named for one pack while
holding two is a recording that misleads the next reader.

Every fixture is a committed, wholly synthetic pair of policy schedules.
No real document reached this machine.
