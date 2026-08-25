# 2026-08-25 — letter pack, development, Qwen3.5-4B, **pack v0.3.0**, scoring v16, pod run (RTX 3090)

- **Pack**: app.kttl.letter-to-actions **v0.3.0** (#552's prompt change)
- **Model**: qwen3.5-4b-q4_k_m.gguf, sha256 `13c16f42…f8a983`
- **Eval set**: development, **425** fixtures (413 + #552's twelve), 1 run
- **Scoring version**: 16
- **Bed digest**: `blake3:4b84b701735475ab9987398f71b5aa96ec98824520fe355e10f4e50058a7a34f`
- **Sidecar**: llama-server 10145 (ad256ded), CUDA0 (RTX 3090), `CMAKE_CUDA_ARCHITECTURES=86`
- **Runtime**: context 8192, parallel 1, **reasoning off**, max answer tokens 4096
- **Machine**: **rented pod** — RunPod, 1× RTX 3090, AMD EPYC 7C13, Ubuntu 24.04.3
- **Commit**: kettle `20ef651` (branch `letter-552-bed`, PR #564), clean tree
- **Verdict**: **PASS**. Obligation 0.00 confident-wrong over 240 against
  a 0.02 ceiling; no_obligation 0.00 over 101 against 0.05; pooled
  obligations 0.98 (n=521); end-to-end 0.98; review 0%.
- **Backs**: `evals/baseline-v16-letter.json`, the v0.3.0 entry in
  `packs/app.kttl.letter-to-actions/tiers.json`, and the re-recorded
  `letter-harm-ceilings` claim.

## The result is null, and that is what it is recorded as

`ask-as-outcome` — the twelve development invoices #552 added, stating
the ask as an outcome — read:

| | old prompt (v0.2.0) | new prompt (v0.3.0) |
|---|---|---|
| recall | 0.08 (95% CI 0.01–0.35) | 0.25 (0.09–0.53) |
| confident-wrong | 0.92 (0.65–0.99) | 0.75 (0.47–0.91) |

1 of 12 against 3 of 12, with intervals overlapping across most of their
length. **This bed cannot distinguish the two prompts.** The prompt edit
is recorded as resolving a contradiction in the specification — the
prompt had contained an actor test and an agency test with no precedence
between them — and **not** as a fix for #552, which stays open.

**The guards held**, which is the first thing this run had to show. The
risk of making agency govern is over-firing, reading the sender's own
described actions as the reader's: `passive-no-obligation` 1.00 over 30,
`courtesy-only` 1.00 over 120, `passive-obligation` no_obligation 1.00
over 90, no_obligation gate 0.00 over 101. No stratum that read 1.00
before reads less now.

**The bed is too small to steer this.** `ask-as-outcome` was sized to
expose the failure, which it does well, and cannot guide an iteration:
at n=12 every subsequent prompt edit reads as noise. Growing it comes
before any further prompt work.

## Two honest gaps in this recording

**The intermediate run's raw recordings do not exist.** The old-prompt
measurement against the *new* bed — the source of the 0.08 figure above
— ran into this same `evals/runs/run1` and was overwritten in place by
the run archived here. Its aggregate survives as
`baseline-before-prompt-edit.json` and `eval-before-prompt-edit.log`,
which carry the per-fixture scores; the per-fixture `raw/*.request.txt`
and `*.response.json` do not. A second eval into the same run directory
costs the first one's recordings, and the only defence is to archive
between runs rather than at the end of the sitting.

**This is the first tiers entry and baseline for this pack measured on a
rented GPU** rather than the M1 Pro. Defensible now that resource fields
left `tiers.json` entirely (#562) and backend score equivalence has been
measured on this bed at two consecutive scoring versions — but it is a
change of practice, and a reader comparing it with the three M1 Pro
entries beside it should know which is which.

Timings are sitting-local telemetry and enter nothing (#562).
