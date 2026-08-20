# 2026-08-10 — renewal pack, Qwen3.5-4B, the scratch sitting #468's attribution rests on

- **Pack**: app.kttl.renewal-diff 0.1.0
- **Model**: qwen3.5-4b-q4_k_m.gguf (4B, Q4_K_M, context 8192)
- **Eval set**: development, 6 fixtures — `sections_repeat` amber-01,
  birch-02, cedar-03, damson-04, and `basis_changed` cedar-03,
  damson-04. A `--fixture-dir` sitting, not a bed run.
- **Prompt version**: blake3:e9509404c36115456b6a58fb33b9e44193e983e41b6ea6a590ee161207cf4889
- **Scoring version**: not recorded — see below.
- **Bed digest**: not recorded — see below.
- **Sidecar**: not recorded — see below.
- **Machine**: Apple M1 Pro, 32GB (inferred, not recorded: the first
  rented-GPU recording is the 11 August entry, so a 10 August local run
  was this machine).
- **Recorded**: 2026-08-10, in two clusters by file mtime — the
  `basis_changed` pair at 18:34–18:35, the four `sections_repeat`
  fixtures at 19:25–19:31.
- **Backs**: #468's attribution, which the
  `2026-08-11-renewal-qwen3.5-4b-v13-phase2` MANIFEST and kettle's
  `assurance/claims.json` both cite in the same words — *"measured on
  the four sections_repeat fixtures (review 17.6% → 0%, step 0.93 →
  1.00)"*. The 11 August close-out run measures a level and explicitly
  disclaims the delta; this sitting is where the delta was seen.

## Why a scratch run is here at all

This repository's retention rule disposes of `--fixture-dir` loops, and
that is the right default. It is admitted under the same rule's other
half — *a cited finding stands on it* — and the citation is not
incidental: two committed documents quote its two numbers, and the
phase-2 MANIFEST says in as many words that #468's attribution rests
here rather than on the run it accompanies. A finding cited by a public
registry whose only evidence was deleted is the failure this archive
exists to prevent.

## What is here, and what is not

A scratch sitting writes no eval report, so the three fields above are
absent at source rather than omitted here: scoring version, bed digest
and sidecar build were never recorded for this run and cannot be
recovered from it. What it does carry is the raw exchanges and the
scored items, which is what a replay needs.

**Only the "after" side is preserved.** The recording is one prompt
state, and 17.6% → 0% is a pair. The "before" half — the same four
fixtures on the pre-#468 vocabulary — was not kept, so this entry
evidences the second number and not the movement. Read the first number
as reported by the phase-2 MANIFEST, not as re-derivable from here.

Its prompt version appears in **no other recording in this archive**.
The 9 August accumulated entry is `blake3:ce46624e…` and every renewal
recording from 11 August onward is `blake3:3f5234da…`; this is
`blake3:e9509404…`, an intermediate state that existed for one working
day. That is the specific reason it could not be reconstructed from any
neighbouring run, and it is why byte-comparison against all seven
archived copies of these fixtures found no match.

## What the items say

Read off the committed `eval-items.json`, counted rather than scored —
the harness's own table from that afternoon was not kept:

- 88 `value-stated` decisions, all outcome `found`: **none routed to a
  person**, which is the 0% review the citation names.
- 88/88 agree with the expectation on term, basis and value together.
  Twenty-four of those are `cover_limit` — the family that answered
  `other` before #468's vocabulary edit, and the reason the fixtures
  were re-run.
- 68 `states-nothing` decisions, all `absent`: no phantom terms.
- Quotes are not counted above. They frequently carry the bare value
  (`£604,700.00`) where the expectation carries the containing sentence,
  which is what #460 later made a refusal — at this prompt state it was
  not yet being asked for.

## Provenance note

Recorded on 20 August 2026 from `evals/runs/468-renewal-v13/` on the
authoring machine, during a cleanup that deleted 93MB of run
directories after checking each against this archive. Fifty-three
directories were checked; forty-seven were already here byte-identical;
these six were not, and that is how they came to be looked at.
`raw/*.request.json` were renamed to `.request.txt` to match a4da204,
the only change made to any file — contents are verbatim.
