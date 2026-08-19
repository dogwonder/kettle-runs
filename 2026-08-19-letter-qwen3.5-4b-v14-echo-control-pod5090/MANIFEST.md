# 2026-08-19 — letter pack, Qwen3.5-4B, scoring v14, the #312 control

- **Pack**: app.kttl.letter-to-actions v0.2.0
- **Model**: qwen3.5-4b-q4_k_m.gguf (4B, Q4_K_M, context 8192, reasoning off)
- **Eval set**: development, 413 fixtures, 1 run
- **Scoring version**: 14
- **Bed digest**: `blake3:9877cdb5be1396123b172e38aa5519b2180ea3e606be526a3dc88b27f437166a`
- **Sidecar**: llama-server 10145 (ad256ded), CUDA0
- **Machine**: **rented** — RunPod, RTX 5090, Linux x86_64, 32 cores
- **Commit**: `71c9d46` — the committed prompts, unchanged
- **Recorded**: 2026-08-19, 11m48s
- **Verdict**: **PASS**
- **Backs**: the refusal of #312's prompt edit. This is the control half;
  its pair is `2026-08-19-letter-qwen3.5-4b-v14-echo-shortened-pod5090`.

## Why this run was taken

#283 measured the verbatim `segment` echo at ~25% of everything this
pack generates and endorsed shortening it as the one lever worth
pulling: ~20% fewer output tokens, ~20% off a bed run, applicable to
every pack. The Rust half — pairing a batch answer to its item on prefix
uniqueness rather than string equality — had already landed. The prompt
half was guarded and unmeasured.

A prompt edit cannot be measured against a baseline recorded on another
machine (`evals/RENTED-GPU.md`: a pod is a different instrument, and a
cross-machine comparison is not evidence that a prompt edit did
nothing). So both sides were run on one rented box, same weights, same
pinned tag, same bed. This is the before.

## The verdict

```
app.kttl.letter-to-actions v0.2.0 · development set · 413 fixtures · 1 run · RTX 5090

model                   obligations (pooled)            e2e   review  time     verdict
qwen3.5-4b-q4_k_m.gguf  0.98 (n=509; 95% CI 0.96–0.99)  0.97  0%      11m48s   PASS

gate / any-letter / obligation     0.00 (n=240) <= 0.02  PASS
gate / any-letter / no_obligation  0.00 (n=101) <= 0.05  PASS
claim containment  4035 candidates; 24 wrong assertions escaped
relations  14 held, 0 failed, 1 unjudgeable
confidence  NO RANKING SIGNAL — every decision declared `high`
```

## A note on the commit

`71c9d46` was the tip of `codex/328-312-replay-prefix` and reached main
squashed as `7e20a0d` (#328). The branch has been deleted, so the hash
above resolves in no clone. What it contained is #328's replay request
identity work on top of `155fac5`, and the pack's prompts exactly as
committed.

## What is in here

`run1/` — one directory per fixture, each with `raw/` holding the
rendered request and the model's answer verbatim, plus `claims.json`,
`eval-items.json` and `run.json`. `eval.log` is the run's own output.
`pod-baseline-app.kttl.letter-to-actions.json` is the baseline it wrote;
it was **not** adopted into kettle, being a control rather than a record.

Every fixture is a committed, wholly synthetic bed letter. No real
document reached this machine, and `pod-eval.sh` offers no
`--fixture-dir` through which one could.
