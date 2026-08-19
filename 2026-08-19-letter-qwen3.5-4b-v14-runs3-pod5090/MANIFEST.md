# 2026-08-19 — letter pack, Qwen3.5-4B, scoring v14, three runs

- **Pack**: app.kttl.letter-to-actions v0.2.0
- **Model**: qwen3.5-4b-q4_k_m.gguf (4B, Q4_K_M, context 8192, reasoning off)
- **Eval set**: development, 413 fixtures, **3 runs**
- **Scoring version**: 14
- **Bed digest**: `blake3:9877cdb5be1396123b172e38aa5519b2180ea3e606be526a3dc88b27f437166a`
- **Sidecar**: llama-server 10145 (ad256ded), CUDA0
- **Machine**: **rented** — RunPod, RTX 5090, Linux x86_64, 32 cores
- **Commit**: `bc3cc9d` (superseded by `5c8611a`, squashed to main as `84222c6`)
- **Recorded**: 2026-08-19, ~11m47s per repeat
- **Verdict**: **PASS**, and **zero spread**
- **Backs**: `evals/baseline-v14-letter.json` and the assurance claim
  `letter-harm-ceilings`, whose `invalidation` now names
  "repeats disagreeing".

## Why this run was taken

#533. Both live registry claims stood `proven` on `--runs 1`, and #83's
stability instrument — which reports the worst run with its spread
beside it — had never been pointed at the measurement anything depends
on. It matters most here, because this ceiling passes by nothing:
Wilson upper 0.02 against a 0.02 ceiling, so **one decision moving in
one repeat** was the difference between proven and withdrawn.

Three letter beds is five and a half hours on an M1 Pro and about
thirty-five minutes here, which is why it had never been done.

## The result

```
app.kttl.letter-to-actions v0.2.0 · development set · 413 fixtures · 3 runs · RTX 5090

model                   obligations (pooled)            e2e   review  time     verdict
qwen3.5-4b-q4_k_m.gguf  0.98 (n=509; 95% CI 0.96–0.99)  0.97  0%      11m46s   PASS

gate / any-letter / obligation     0.00 (n=240) <= 0.02  PASS
gate / any-letter / no_obligation  0.00 (n=101) <= 0.05  PASS
claim containment  4035 candidates; 24 wrong assertions escaped
relations  14 held, 0 failed, 1 unjudgeable
confidence  NO RANKING SIGNAL — every decision declared `high`

stability  413 of 413 fixtures carry a Stability block at runs: 3
           NOTHING MOVED — every step score, end-to-end score and
           review rate reports an identical low and high
```

Near determinism at temperature 0 under a grammar was always likely.
It is now measured rather than assumed, and validation enforces it: a
baseline recording a moved spread downgrades its claim, naming the
fixture that moved, while an absent one does not. What is refused is
measured-and-moved, never unmeasured.

## Something this run corrected by accident

The baseline it replaced was recorded on 14 August, hours before
`ae297db` taught the confidence bucket's error rate to count only
*asserted* decisions — a routed decision was never asserted, so it
cannot be confidently wrong. The old file carried n=476 where every run
since reads n=475. No gate depends on it, but the registry had been
citing a file that predated a correction to itself.

## What is in here

`run1/`, `run2/`, `run3/` — one directory per fixture per repeat, 413
each, `raw/` holding the rendered request and the model's answer
verbatim. The repeats nearly did not survive: `pod-eval.sh` archived
`evals/runs/run1` alone, which was every directory until `--runs` could
be passed through it, so the first stability run came home with its
scores — aggregated into the baseline — and without two thirds of the
answers they were computed from. Fixed in the same PR; these were
recovered by hand before the box was destroyed.

Every fixture is a committed, wholly synthetic bed letter. No real
document reached this machine.
