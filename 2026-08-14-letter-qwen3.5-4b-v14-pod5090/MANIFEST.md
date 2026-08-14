# 2026-08-14 — letter pack, Qwen3.5-4B, scoring v14, on a rented GPU

- **Pack**: app.kttl.letter-to-actions 0.2.0
- **Model**: qwen3.5-4b-q4_k_m.gguf (4B, Q4_K_M, context 8192)
  — sha256 `13c16f426047e2de38cd075bdade4a7bcbc8c774384876f677740cda65f8a983`,
  verified on the pod against `models.json`.
- **Eval set**: development, 413 fixtures
- **Scoring version**: 14
- **Bed digest**: `blake3:fd0b22a9a4d192bc9ddbfab5d548afe3617d703d90d0f768c53f054454791973`
- **Sidecar**: llama-server 10145 (ad256ded), built from source on the
  pod with CUDA; device `CUDA0 (NVIDIA GeForce RTX 5090)`
- **Runtime policy**: context 8192, parallel 1, reasoning off, max
  answer tokens 4096 (#232)
- **Machine**: **rented** — RunPod, NVIDIA RTX 5090 (Blackwell, 32GB),
  AMD EPYC 7543 32-core, 945GB RAM, Ubuntu 24.04.3
- **Tree**: clean at `2288769`, no hand-applied patches
- **Recorded**: 2026-08-14, stamped 09:28:44Z; 14m39s wall clock
- **Backs**: the M7 exit measurement and the findings below. Verdict
  **FAIL** as recorded. No baseline was adopted from it.
  It also backs **kettle PR #508**, every number in which was measured
  by replaying these answers — the two gate changes, the verdict, the
  containment counts and the relation's new state. Nothing there was
  re-run on a GPU, so this recording is the whole evidence for a merged
  claim.

## The result in one line

Every mature stratum in the bed answered perfectly, and twelve fixtures
added days earlier failed 12 of 12:

- `gate / any-letter / obligation` — 0.05 (n=252) against a 0.02
  ceiling: **exactly 12 confident-wrong decisions**, all of them the
  invoice shape.
- `gate / any-letter / no_obligation` — 0.11 (n=114) against 0.05:
  **13 decisions, not 12**. Twelve are the same documents counted from
  the other side; the thirteenth is a separate defect, in *Relations*
  below. 13/114 and 12/114 both round to 0.11, which is how one
  invention hid behind twelve — read the counts, never the rate.

For contrast, in the same run: `no-obligation` 1.00 on n=916 with zero
confident-wrong, `multiple-obligations` 1.00 on n=211, `three-asks`
1.00 on n=126, and every injection family from #433 clean.

## What the twelve are

#504 added an invoice/table shape to the bed; #503 (#406 Slice A) made
column geometry survive segmentation. Both landed. The fixture:

```
Please find our invoice for your parking charge below. Payment of the
total is due by the date shown beside it.

Due date              Sub total     £150.00
22 January 2026       VAT           £30.00
                      Total         £180.00
```

**Slice A worked.** The model received `"Due date 22 January 2026"` as
one passage and `"Sub total £150.00 VAT £30.00 Total £180.00"` as
another. No interleaving — the defect #406 was opened for is gone.

**The obligation still isn't in any one passage.** The ask is in the
prose, the date is in row one, the amount is in row three. So:

- On `"Due date 22 January 2026"` the model answered `obligations: []`
  at **high** confidence. In isolation that is a defensible reading — a
  bare row with no verb — and the bed expects a payment obligation
  there. Miss, ×12.
- On the prose it asserted a payment obligation with
  `deadline: "by the date shown beside it"`, no amount, **high**
  confidence, where the bed expects nothing. Invention, ×12.

## The part that is not contestable

Kettle would tell a person *"Pay the total invoice amount, by the date
shown beside it"* — no sum, no date, marked certain. Whatever the bed
ought to expect, that report cannot be acted on.

No guardrail caught it. This pack runs two (`schema`, `pairing`);
25 wrong assertions escaped and 0 were contained. v14's rule one passes
here **correctly**: the quote does contain its value. The value is a
phrase that resolves to nothing, and claim-local checking cannot see
that by construction.

Compare the renewal run of the same afternoon, which ran seven
guardrails: `pack_coverage` caught 7 and contained 7, `review_routing`
contained 4, 8 escaped. The pack that had the harder failure history now
has the machinery; the pack that looked clean at v13 has almost none.

## The part that is contestable, and should not have been gating

The bed places the obligation on the row carrying the date. The model
places it on the prose that says "pay". Both readings are defensible —
which by the rule settled on 11 August means it belongs in its own
**ungated stratum with a named promotion condition**, not inside
`any-letter`. As committed, `in-a-table` and `invoice-totals` gate, so
an open authoring question reads as a gate failure.

This is the #457/#456 pattern a third time: a genuine ambiguity authored
into a bed and then scored as a model error. The difference is that this
time a real product defect sits underneath it, so the fix is not only to
the bed.

## What was done with it (kettle PR #508, merged 14 August)

Both, by replaying these answers — no second GPU run:

- `invoice_totals` decisions left `any-letter`, keeping their own
  slices. The prose that points at the table became a scored item
  expecting nothing, because an assertion on an *unscored* passage is
  synthesised as an unauthored item, and an unauthored item carries the
  pack's whole gated stratum set — so ungating the shape alone would
  have left those twelve inventions in the gate.
- The thirteenth was fixed in Rust:
  `modality::grants_without_requiring` routes an obligation read out of
  a permission to a person rather than asserting it.

Replayed, this recording then gives `obligation` 0.00 (n=240) PASS,
`no_obligation` 0.00 (n=101) PASS, **verdict PASS**, `review_routing`
1 contained where the run as scored contained 0 — and the relation
above becomes *unjudgeable* rather than passing, naming the claim that
was routed, because a claim nobody asserted is not one a relation can
judge.

The recorded verdict stays **FAIL**: that is what this run measured,
and the entry is not restated to match a later fix.

## Relations

14 held, 1 failed, 0 unjudgeable.
`controlled-must-to-may-development` FAILED — "the declared change never
appeared on the left side". That machinery (#465) had never run against
a full committed bed before today, so the twin was checked before the
failure was cited.

**It checked out: a real defect, not the false alarm the last two
were.** On *"You may also confirm in writing that you have made this
payment, within 28 days of the date of this letter"* — the passage whose
authored edit is that one word — the run asserted a `response`
obligation at **high** confidence. It is also the thirteenth
`no_obligation` decision above, so two instruments reported one defect
from two directions: a permission read as a requirement, inventing work
for a person.

## Pod notes

The timings are the pod's and are not a tier claim. The letter bed ran
in 14m39s here against ~2h on the M1 Pro; that ratio is a fact about a
5090, not about anybody's laptop.

Scores across backends remain asserted rather than measured. It costs
nothing here — the bed moved for v14, so #320 refuses the v13
comparison regardless, and no `--baseline` was passed.
