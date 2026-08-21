# 2026-08-21 — letter pack, Qwen3.5-4B, scoring v14, development, the bed #544 changed

- **Pack**: app.kttl.letter-to-actions 0.2.0
- **Model**: qwen3.5-4b-q4_k_m.gguf (4B, Q4_K_M, context 8192)
- **Eval set**: development, 413 fixtures, **3 runs**
- **Scoring version**: 14
- **Bed digest**: `blake3:57b37e87570cc6612fbaa96c1e633e2382b5ea2dedbf997a6d83a0c89df4826a`
- **Sidecar**: llama-server 10145 (ad256ded), built from source on the
  pod with CUDA; device `CUDA0 (NVIDIA GeForce RTX 5090) (0000:01:00.0)`
- **Machine**: **rented** — RunPod, NVIDIA RTX 5090, Linux x86_64,
  16-core Ryzen 9 9950X, 123GB
- **Tree**: clean at `347067b`, no hand-applied patches. That commit is
  byte-identical in tree to `d91d2d7` on main (PR #547 squash-merged
  while this was provisioning; the trees were compared before the run
  was trusted).
- **Recorded**: 2026-08-21, stamped 10:55:21Z; 13m06s wall clock
- **Backs**: `evals/baseline-v14-letter.json` as adopted in PR #550, and
  the assurance claim `letter-harm-ceilings`, re-recorded against the
  bed digest above.

## The result

```
qwen3.5-4b-q4_k_m.gguf  1.00 (n=509; 95% CI 0.99–1.00)  e2e 1.00  review 0%  13m06s  PASS

gate / any-letter / obligation     0.00 (n=240) <= 0.02  PASS
gate / any-letter / no_obligation  0.00 (n=101) <= 0.05  PASS
points-at-a-table   obligation      12/12, confident-wrong 0.00
in-a-table          no_obligation   12/12, confident-wrong 0.00
relations                          14 held, 0 failed, 1 unjudgeable
containment                        4035 candidates, 1 surfaced, 0 escaped
```

## Read the improvement correctly: the bed moved, the model did not

Against the 19 August run this replaces, escapes went 24 → 0 and pooled
0.98 → 1.00. **None of that is the model getting better.** Same weights,
same prompt, same temperature, same sidecar build — and replaying the
earlier run confirmed the answers are byte-identical.

What changed is #544. The bed used to expect a payment obligation read
out of a bare due-date row — `Due date 6 March 2026`, naming no action
and no party — which no closed question about that passage alone can
yield, and which the run was therefore marked wrong on twelve times out
of twelve. The ask is now scored where the letter makes it, and the row
is where invention is measured.

So this entry records a bed becoming honest. A reader comparing the two
baselines without that sentence would conclude the model improved, and
would be wrong.

## Stability

All 413 fixtures reported **one record digest** and an identical low and
high for every step score, end-to-end score and review rate across the
three runs. Nothing moved.

That matters here more than usual: the obligation ceiling passes by
nothing — Wilson upper 0.02 against a 0.02 ceiling — so a single
decision moving in a single repeat is the difference between proven and
withdrawn (#533).

## The pod, and what it cost

The build died once at the link step with `ld terminated with signal 7
[Bus error]` while the volume had room. `/workspace` is MooseFS and
`rust-lld` mmaps its output; `pod-eval.sh`'s 2GB `dd` probe does
ordinary writes and so cannot fail on that. Fixed by putting
`CARGO_TARGET_DIR` and `TMPDIR` on the container overlay. Written up in
`evals/RENTED-GPU.md` (PR #551).

Bed fixtures only. No private input reached this machine.
