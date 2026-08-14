# 2026-08-14 — letter pack, Qwen3.5-4B, scoring v14, the adopted baseline

- **Pack**: app.kttl.letter-to-actions 0.2.0
- **Model**: qwen3.5-4b-q4_k_m.gguf (4B, Q4_K_M, context 8192)
- **Eval set**: development, 413 fixtures
- **Scoring version**: 14
- **Bed digest**: `blake3:9877cdb5be1396123b172e38aa5519b2180ea3e606be526a3dc88b27f437166a`
- **Sidecar**: llama-server 10145 (ad256ded), built from source on the
  pod with CUDA; device `CUDA0 (NVIDIA GeForce RTX 5090) (0000:ca:00.0)`
- **Machine**: **rented** — RunPod, NVIDIA RTX 5090, Linux x86_64,
  64 cores
- **Tree**: clean at `ebace9b`, no hand-applied patches
- **Recorded**: 2026-08-14, stamped 15:22:43Z; 12m47s wall clock
- **Backs**: `evals/baseline-v14-letter.json`, adopted into the repo as
  the letter pack's current prompt-edit floor, and the assurance claim
  `letter-harm-ceilings`, which this run returned to **proven** after
  three days unproven on v13 evidence.

## The result

```
qwen3.5-4b-q4_k_m.gguf  0.98 (n=509; 95% CI 0.96–0.99)  e2e 0.97  review 0%  12m47s  PASS

gate / any-letter / obligation     0.00 (n=240) <= 0.02  PASS
gate / any-letter / no_obligation  0.00 (n=101) <= 0.05  PASS
relations                          14 held, 0 failed, 1 unjudgeable
containment                        4035 candidates, 1 surfaced, 24 escaped
```

The pack's first clean verdict on a real run. Its two immediate
predecessors both failed: the 14 August exit run on twelve invoice
fixtures, and everything before it on v13 evidence that a scoring bump
had aged out.

## What makes this entry worth keeping is the method, not the score

**Every figure above was predicted exactly by replay.** PR #508 changed
the bed (taking #504's invoice shape out of the gated stratum, and
scoring the prose that points at a table) and added a deterministic
modality rule, then measured the result by re-scoring the *recorded
answers* of the 14 August exit run — no GPU. It reported obligation
0.00 (n=240), no_obligation 0.00 (n=101), verdict PASS, 1 contained and
24 escaped, and relations 14/0/1.

This run, on a fresh pod against the same weights and sidecar,
reproduced all of it. So the replay was not an approximation of a run
somebody would later have to do properly: it was the same measurement,
and the archive is what let it happen a day early and for nothing.

That is the argument for this repo, made once with numbers.

## The unjudgeable relation is not a failure

`controlled-must-to-may-development` reads *unjudgeable* rather than
held or failed, and the reason is in the run: the claim it turns on was
**routed to a person** by the #406 modality rule instead of being
asserted. A claim nobody asserted is not one a relation can judge, and
saying so is more honest than passing it.

On the exit run three hours earlier the same relation FAILED, and that
failure was real — *"You may also confirm in writing…"* read as a
`response` obligation at high confidence. It was the thirteenth
`no_obligation` confident-wrong, in a write-up that counted twelve.

## Confidence

```
confidence / high: 476 decisions; 24 wrong; 1 routed to review; error 0.05
confidence / untraceable: 3
NO RANKING SIGNAL — every decision was declared `high`
```

First time this has been measured on a real run rather than a replay,
and it agrees with the replay too. 476 of 479 decisions carry one
level, so routing by declared confidence separates nothing on this
pack. #429.
