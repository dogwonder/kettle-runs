# 2026-08-14 — subscription pack, Qwen3.5-4B, scoring v14

- **Pack**: app.kttl.subscription-audit
- **Model**: qwen3.5-4b-q4_k_m.gguf (4B, Q4_K_M, context 8192)
- **Eval set**: development, 84 fixtures (81 generated, plus the three
  hand-authored `statement-*` fixtures that predate the generated bed —
  all committed and wholly synthetic)
- **Scoring version**: 14
- **Sidecar**: llama-server 10145 (ad256ded), CUDA, built on the pod;
  device `CUDA0 (NVIDIA GeForce RTX 5090)`
- **Machine**: **rented** — RunPod, NVIDIA RTX 5090, Linux x86_64, 64 cores
- **Recorded**: 2026-08-14; 5m06s wall clock
- **Verdict**: **FAIL**. No baseline adopted from it.
- **Backs**: the measured note on the assurance claim
  `confidence-predicts-correctness` (#429). Those numbers exist nowhere
  else, which is why this entry is not optional.

## Why this run was taken

To answer one question: **does the confidence tag Kettle shows a person
predict whether the answer is right?** This is the only pack that
renders that tag — `HIGH`/`MEDIUM`/`LOW` in the report, and on the
public demo — and it had never been measured. Its previous baseline is
scoring v5 from 31 July, on a 7B.

So the FAIL below is a **first v14 measurement, not a regression**. Two
variables moved at once against the v5 record: the scoring and the
model.

## The verdict

```
qwen3.5-4b-q4_k_m.gguf  normalise 0.69 (n=900)  e2e 1.00  review 39%  5m06s  FAIL

gate / any-statement / subscription                0.12 (n=32)
gate / annual-subscription-once-yearly / subscr.   0.25 (n=8)
gate / free-trial-conversion / subscription        0.12 (n=8)
gate / any-statement / not_subscription            0.02 (n=60)  PASS
gate / price-rise-mid-series / subscription        0.00 (n=8)   PASS
containment  1800 candidates, 355 surfaced, 150 escaped
relations    0 held, 0 failed, 4 unjudgeable
```

The shape is specific rather than general. `subscription` precision is
1.00 (n=288) with recall 0.97 — the model is **not inventing**
subscriptions, it is **missing** them, 53 decisions with 15 attributed
`via category_map`. `regular_spend` precision 0.19 (n=16) is the mirror
image: real subscriptions landing as regular spending. That is #302's
confident-denial shape, now measured at v14.

**Caveat before citing any of it: 4 relations, 0 held, all
unjudgeable.** An all-unjudgeable relation set has twice been the
harness rather than the model, and that has not been checked here.

## The confidence answer, and the defect it exposed

Replayed through the per-question confidence split (#429) on 15 August:

```
confidence / high:   54 decisions;  5 wrong;  6 routed;  error 0.10 (n=48 asserted;  CI 0.05–0.22)
confidence / medium: 19 decisions;  6 wrong;  5 routed;  error 0.43 (n=14 asserted;  CI 0.21–0.67)
confidence / low:    40 decisions;  0 wrong; 40 routed;  error undefined (n=0 asserted)
confidence / untraceable: 63
UNPROVEN — the levels varied and no two intervals separated
```

**High to medium points the right way** — more confident, less wrong —
which is the opposite of what the letter pack (no ranking signal) and
the renewal pack (inverted) show. The intervals overlap, so this bed
cannot establish it, and 14 asserted `medium` decisions never could.
What that claim needs is a bigger bed, not a better model.

**The first reading of this same recording said INVERTED, and it was
wrong.** All 40 `low` decisions had been routed to review; a routed
decision is never asserted and so cannot be confidently wrong, and its
guaranteed 0.00 separated from `medium`. The scorer had divided by all
decisions rather than by asserted ones — which #429 had specified in
the words *error among automatically asserted items*, and which had not
been implemented. Fixed the same day; a bucket asserting nothing now
has an undefined rate that nothing may rank against.

This recording is therefore the evidence for two things: what the pack
scores, and the fact that the instrument caught itself. Replaying it is
what found the defect.

## Addendum, 17 August 2026: the surface described above is gone

"This is the only pack that renders that tag — `HIGH`/`MEDIUM`/`LOW` in
the report, and on the public demo" was true when this was written and
is not true now. kettle#519 removed the graded tag from both surfaces:
the app's evidence row no longer carries one, and the report's tag reads
`SETTLED` or `UNSURE`. The model's confidence answers are still recorded
in every run directory, including this one, because measurement needs
them and a person does not.

**Nothing measured here changes.** The buckets, the counts and the
UNPROVEN verdict above are what this recording says, and removing a
surface is not evidence about it — `confidence-predicts-correctness`
stays unproven on the same review route, which still wants a bigger bed
rather than a better model. What the removal changes is the stake: the
question is now "should this signal ever be shown again", where before
it was "is what we are already showing worth showing".

Recorded as an addendum rather than a correction. A run recording is
dated evidence, and rewriting the reason a measurement was taken would
make the archive agree with the present at the cost of saying what was
believed at the time.
