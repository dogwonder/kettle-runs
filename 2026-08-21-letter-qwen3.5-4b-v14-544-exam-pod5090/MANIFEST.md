# 2026-08-21 — letter pack, Qwen3.5-4B, scoring v14, **exam**, the first run of the invoice shape on the sealed set

- **Pack**: app.kttl.letter-to-actions 0.2.0
- **Model**: qwen3.5-4b-q4_k_m.gguf (4B, Q4_K_M, context 8192)
- **Eval set**: **exam**, 413 fixtures, **3 runs**
- **Scoring version**: 14
- **Bed digest**: `blake3:033c28923886214a1b5f5cfe2dd7c0ff749c03f14a59c40c540a60d7c6449376`
- **Sidecar**: llama-server 10145 (ad256ded), built from source on the
  pod with CUDA; device `CUDA0 (NVIDIA GeForce RTX 5090) (0000:01:00.0)`
- **Machine**: **rented** — RunPod, NVIDIA RTX 5090, Linux x86_64,
  16-core Ryzen 9 9950X, 123GB
- **Tree**: clean at `347067b`, tree-identical to `d91d2d7` on main
- **Recorded**: 2026-08-21, stamped 11:56:39Z; 13m23s wall clock
- **Backs**: nothing yet. It is evidence for **#552**, and it is why
  `in-a-table`'s promotion condition stays open.

## The result

```
qwen3.5-4b-q4_k_m.gguf  0.99 (n=509; 95% CI 0.97–0.99)  e2e 0.98  review 0%  13m23s  PASS

gate / any-letter / obligation     0.00 (n=252) <= 0.02  PASS
gate / any-letter / no_obligation  0.00 (n=101) <= 0.05  PASS
points-at-a-table   obligation      recall 0.42 (5/12), confident-wrong 0.58
in-a-table          no_obligation   recall 0.92 (11/12), confident-wrong 0.08
relations                          14 held, 0 failed, 1 unjudgeable
containment                        4030 candidates, 1 surfaced, 8 escaped
```

## Why this run exists and what it found

The invoice shape had never been measured on the sealed set. #544
settled where an invoice's obligation sits and the development run
above returned 12/12 on both sides of it. This run asked the same
question of the exam voice and got **5 of 12**.

In seven of twelve exam invoices the run asserts **no payment
obligation anywhere** — a person is shown an invoice and told it asks
nothing of them. That is the miss class, the one this pack holds
tightest.

Three facts recorded here because they are what makes it a defect
rather than a score:

1. **The prose is byte-identical across all twelve.** Only the subject
   noun varies. The same sentence yields an obligation in five letters
   and nothing in seven.
2. **It is deterministic.** All 12 invoice fixtures reported one record
   digest and no movement across the three runs. A stable split, not
   sampling noise.
3. **All twelve are declared `high`**, the seven silences as
   confidently as the five correct answers, with review rate 0%.

The two voices word the ask differently — development's *"Payment of
the total is due by the date shown beside it"* against exam's *"The
amount shown as due should reach us by the date given against it"* —
and the exam construction's grammatical subject is the amount rather
than the reader. Under the prompt's own #458 rule, "no obligation" is a
defensible reading of it. That is why the split is arbitrary rather
than simply wrong, and it is #552's subject.

**And the pack PASSes.** `any-letter` reads 0.00 because invoice
decisions do not join it. A stratum at 42% recall inside a passing pack
is exactly the structural blindness #544 was filed about, reproduced on
the sealed set.

## An archive note, because a recording must describe itself

As transferred, `run2` and `run3` carried 214 and 413 leftover
**development** directories: the `rm -rf evals/runs/run*` between the
two pod runs was interrupted part-way. They are stripped here. Before
dropping them, every one was compared against the development archive
beside this entry — 626 byte-identical, and one an empty directory
where the delete stopped mid-way. Nothing was lost.

The measurement was never affected: the eval scores the fixtures it
ran, and `--runs 3` disables `--resume`. But a directory labelled "exam
run" containing a development run would be a recording that misdescribes
itself, which is what #303 and #320 exist to prevent.

Bed fixtures only. No private input reached this machine.
