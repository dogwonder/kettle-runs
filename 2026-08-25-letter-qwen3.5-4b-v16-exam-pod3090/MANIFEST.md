# 2026-08-25 — letter pack, **exam set**, Qwen3.5-4B, scoring v16, pod run (RTX 3090)

- **Pack**: app.kttl.letter-to-actions **v0.2.0** (the prompt as it stood before #552)
- **Model**: qwen3.5-4b-q4_k_m.gguf, sha256 `13c16f42…f8a983`
- **Eval set**: **exam** (the sealed holdout), 413 fixtures, 1 run
- **Scoring version**: 16
- **Sidecar**: llama-server 10145 (ad256ded), CUDA0 (RTX 3090), `CMAKE_CUDA_ARCHITECTURES=86`
- **Runtime**: context 8192, parallel 1, **reasoning off**, max answer tokens 4096
- **Machine**: **rented pod** — RunPod, 1× RTX 3090, AMD EPYC 7C13, Ubuntu 24.04.3
- **Commit**: kettle `e29948d`, clean tree
- **Verdict**: PASS, and the pass is the point — see below.
- **Backs**: the finding in #552 and PR #564, `invoice-totals`' discharged
  promotion condition in `pack.json`, and the `ask-as-outcome` stratum
  added to the development bed.

## What this run established

It isolated a failure that had been visible only as an aggregate. Every
stratum in the sealed set answered 1.00 **except one**:

| Stratum | construction | decisions | recall | confident-wrong |
|---|---|---|---|---|
| `payment-anchored` | `falls due` | 36 | 1.00 | 0.00 |
| `undated-relative` | `should be completed and returned` | 31 | 1.00 | 0.00 |
| `passive-voice` | `must be received` | 30 | 1.00 | 0.00 |
| `points-at-a-table` | `should reach us` + pointing | 12 | **0.42** | **0.58** |

So the difficulty is **one construction, not a class of them**. It is
not weak modality — `falls due` carries no modal at all and scores
perfectly. It is not the word "should". It is an inanimate subject
described reaching an outcome, where the deadline points off the
passage.

All **seven** wrong assertions that escaped anywhere in the exam set
came from that single stratum, and the schema and pairing guardrails
contained none of them: a quote rule cannot reach an obligation that was
never asserted. The miss class has no containment story, by construction.

**Both gates read 0.00 and the pack PASSes** while a stratum sits at 42%
recall, because `points-at-a-table` decisions do not join `any-letter`.
That is the structural blindness #552 was filed about, reproduced on the
sealed set.

## Why it is the last exam reading for now

This run predates the #552 prompt change and the bed growth. The exam
set has deliberately **not** been re-read since: prompt work does not
get to see the holdout (#317), and one reading as a verdict belongs
after the development picture is settled. A later exam run at pack
v0.3.0 is the verdict; this is the diagnosis.

Timings are sitting-local telemetry and enter nothing (#562).
