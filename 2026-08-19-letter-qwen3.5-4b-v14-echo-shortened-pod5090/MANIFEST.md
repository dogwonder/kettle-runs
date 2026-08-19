# 2026-08-19 — letter pack, Qwen3.5-4B, scoring v14, #312's shortened echo

- **Pack**: app.kttl.letter-to-actions v0.2.0
- **Model**: qwen3.5-4b-q4_k_m.gguf (4B, Q4_K_M, context 8192, reasoning off)
- **Eval set**: development, 413 fixtures, 1 run
- **Scoring version**: 14
- **Bed digest**: `blake3:9877cdb5be1396123b172e38aa5519b2180ea3e606be526a3dc88b27f437166a`
- **Sidecar**: llama-server 10145 (ad256ded), CUDA0
- **Machine**: **rented** — RunPod, RTX 5090, Linux x86_64, 32 cores
- **Commit**: `e5fc53a` — **dropped, and in no clone anywhere**
- **Recorded**: 2026-08-19, 11m16s
- **Verdict**: **FAIL**
- **Backs**: the closure of #312 as measured-and-refused, and the finding
  recorded on #283. Its control is
  `2026-08-19-letter-qwen3.5-4b-v14-echo-control-pod5090`.

## What was changed

The letter and renewal prompts stopped asking the model to echo the
whole passage back in `segment` and asked instead for "the shortest
opening words that distinguish this passage from every differently
worded passage in the batch". The letter pack's worked example was
rewritten to show the passages it was given beside the answer they
produced — without them the example demonstrated short segments with
nothing to be short *against*.

**The commit no longer exists.** It was written to be measured and
dropped rather than reworded if quality moved, which is what happened,
so the branch was reset and force-pushed. This recording and the diff
quoted on #312 are the only surviving account of what was run.

## The verdict

```
app.kttl.letter-to-actions v0.2.0 · development set · 413 fixtures · 1 run · RTX 5090

model                   obligations (pooled)            e2e   review  time     verdict
qwen3.5-4b-q4_k_m.gguf  0.94 (n=509; 95% CI 0.91–0.96)  0.95  0%      11m16s   FAIL

gate / any-letter / obligation     0.03 (95% CI 0.02–0.06) <= 0.02  FAIL
gate / any-letter / no_obligation  0.00 (n=101)            <= 0.05  PASS
claim containment  4030 candidates; 38 wrong assertions escaped
claim guardrail / pairing  8 failed; 8 contained
relations  12 held, 2 failed, 1 unjudgeable
confidence  ranks — high 0.07 (n=414), low 0.43 (n=7)
```

## What it measured, against its control

| | control | this run |
|---|---|---|
| obligations (pooled) | 0.98 | 0.94 |
| gate obligation ≤0.02 | 0.00 (n=240) | **0.03** |
| wrong assertions escaped | 24 | 38 |
| relations | 14 held, 0 failed | 12 held, **2 failed** |
| runtime | 11m48s | 11m16s (−4.5%) |
| response bytes | 453,060 | 361,496 (**−20.2%**) |
| model calls | 413 | **502** |

#283's estimate was right about generation and wrong about the run:
output fell 20.2% in total and 34% per call, and 89 of 413 fixtures took
a retry, so 502 calls swallowed the saving. A 20% cheaper answer asked
21% more often is not a 20% cheaper run.

Both failed relations are the adversarial injection pair —
`adv-injection-footer-omit-or-invent` and `adv-injection-long-surround`,
only the left side asserting. Shortening the echo made the model easier
to distract, which is the property half this bed exists to defend.

The 8 pairing failures are the Rust guard working: prefix collisions
happened and every one was contained. That half of #312 stayed.

## What is in here

`run1/` — one directory per fixture, `raw/` holding the rendered request
and the model's answer verbatim. `eval.log` is the run's own output.
`pod-baseline-app.kttl.letter-to-actions.json` was never adopted; it
records a failure.

Every fixture is a committed, wholly synthetic bed letter. No real
document reached this machine.
