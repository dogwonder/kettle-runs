# 2026-08-21 — letter pack, Qwen3.5-4B, scoring v14, **exam**, the re-authored voices that were reverted

- **Pack**: app.kttl.letter-to-actions 0.2.0
- **Model**: qwen3.5-4b-q4_k_m.gguf (4B, Q4_K_M, context 8192)
- **Eval set**: **exam**, 413 fixtures, **3 runs**
- **Scoring version**: 14
- **Bed digest**: `blake3:6543bf2f7a3832727cdccd842962c0dbb1f087fe5ed96f14d7a234a00284defe`
- **Sidecar**: llama-server 10145 (ad256ded), CUDA, device
  `CUDA0 (NVIDIA GeForce RTX 5090) (0000:01:00.0)`
- **Machine**: **rented** — RunPod, NVIDIA RTX 5090, Linux x86_64, 32 cores
- **Tree**: `0b5afc95781ce03307a2fe45e444f8bcd41aecde`, tagged
  `evidence/552-exam-reauthored` in `dogwonder/kettle`
- **Runtime**: reasoning **off**, parallel 1, max answer tokens 4096
- **Recorded**: 2026-08-21; 11m45s wall clock
- **Backs**: nothing, and it never will. It is the evidence that the bed
  it measures was wrong, and the reason that bed no longer exists.

## Read the tag before anything else

**The bed this run measures is not on `main` and never was.** Seven of
the letter pack's twelve shapes had their exam prose re-authored, the
run below was recorded on the result, and the result is why the change
was reverted the same afternoon. `git checkout evidence/552-exam-reauthored`
is the only way to reproduce the fixtures these recordings answer;
without it the digest above matches nothing.

## The result

```
qwen3.5-4b-q4_k_m.gguf  0.98 (n=509; 95% CI 0.96–0.99)  e2e 0.97  review 0%  11m45s  FAIL

gate / any-letter / obligation     0.05 (n=252) <= 0.02  FAIL
gate / any-letter / no_obligation  0.00 (n=101) <= 0.05  PASS
relations                          14 held, 0 failed, 1 unjudgeable
```

Against the 21 August exam run on the unmodified bed
(`…-544-exam-pod5090`, same model, same sidecar, same scoring):

| | unmodified bed | re-authored bed |
|---|---|---|
| gate `any-letter` / obligation | 0.00 (n=252) PASS | **0.05 (n=252) FAIL** |
| `payment_anchored` / `dated-anchor` recall | 1.00 (36/36) | **0.67 (24/36)** |
| `payment_relative` recall | 1.00 (47/47) | **0.91 (43/47)** |
| `points-at-a-table` recall | 0.42 (5/12) | 0.33 (4/12), untouched, CIs overlap |
| `passive-voice` obligation | 1.00 (30/30) | 1.00 (30/30) |
| `three-asks`, `repeated-ask`, `undated-relative`, `payment-month-end` | 1.00 | 1.00 |

The bed moved, so this is not a baseline comparison and the harness
would refuse one (#320). Both are pod runs on the same sidecar and the
same weights, so the instrument is held constant; the two logs are
compared directly and by stratum, not by baseline diff.

## What it says, which is not what it was run to find out

The edit was made on the reasoning that the exam voice had drifted
*harder* than development — development asks in the imperative, exam
asks with nobody named — and that this confounds every comparison the
pack draws between the sets. The inconsistency is real. The premise that
it was a difficulty gap was inferred and never measured, and this run
says it was wrong: the actorless shapes scored 36/36 and 47/47 **as
actorless**, and `passive-voice`, the stratum built to measure
actorlessness, scores 30/30 in both voices here and before.

What the rewrite actually disturbed was the sentence around the
deadline. On `payment_anchored` the model still records the obligation
every time — it copies a different deadline:

```
"You must clear £12.00 within 45 days of 23 August 2026. Please quote ELS-3391 when you pay."
  → deadline "within 45 days of 23 August 2026"   scored wrong
  → deadline "within 45 days"                     what the bed expects, date in `anchor`
```

Both are the words the letter uses, which is all the prompt asks for. So
the boundary between `deadline` and `anchor` is undetermined by the
prompt, and the previous wording merely landed on the bed's side of it
36 times running. `payment_relative` fails differently and worse: one
answer came back `"within 22 days"` for a 21-day letter.

That is #457's defect and #544's on a third axis — an expectation the
prompt's own wording does not uniquely determine.

**Corrected after reading the items** (same day): the obligations were
not missed. All 36 were **found** — `obligation_key` matched every one,
`due` identical on both sides. What demotes them is
`same_assertion_as`, which compares `deadline` verbatim, so a faithful
copy of the letter's words lands in the confident-wrong cell while the
obligation it describes is recorded as found.

Chasing that turned up a standing defect these recordings also
evidence. Three parts of the scorer answer "is the wording part of the
claim" three different ways: `obligation_key` ignores both `deadline`
and `anchor` when the deadline resolves (#287), `same_assertion_as`
takes `deadline` verbatim but reads `anchor` by the date it names
(#452), and `support` takes both verbatim. The consequence is visible
in the unmodified runs beside this one: `support` fails 78 times per
exam run and 79 per development run, every one on `anchor` alone, and
nothing consumes it — the `month-end` stratum is 78 expected, 78 found,
**0 support-pass**, and reports recall 1.00.

## Why it is archived rather than deleted

It is the only measurement of a bed that no longer exists, and the whole
argument for reverting rests on it. `STAGED_VOICE_DIVERGENCES` in
`crates/runner/tests/letter_bed.rs` cites these numbers in the message
it fails with, so the next person to read the divergence as a small
tidy-up is told what it cost before making it.

Bed fixtures only. No private input reached this machine.
