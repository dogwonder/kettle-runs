# 2026-08-23 — letter pack, Qwen3.5-4B, scoring v15, on the M1 Pro

- **Pack**: app.kttl.letter-to-actions v0.2.0
- **Model**: qwen3.5-4b-q4_k_m.gguf (4B, Q4_K_M, context 8192)
- **Eval set**: development, 413 fixtures, 1 run
- **Scoring version**: 15
- **Bed digest**: `blake3:57b37e87570cc6612fbaa96c1e633e2382b5ea2dedbf997a6d83a0c89df4826a`
- **Sidecar**: llama-server 10145 (ad256ded3), Metal (MTL0), bundled in `sidecars/macos-arm64/`
- **Runtime**: context 8192, parallel 1, **reasoning off**, max answer tokens 4096
- **Machine**: **local** — Apple M1 Pro, 32GB, macOS 26.5.2
- **Recorded**: 2026-08-23, 107m12s wall clock
- **Verdict**: **PASS**
- **Backs**: the v15 entry in `packs/app.kttl.letter-to-actions/tiers.json`,
  the removal of the pack's staged stale floor from
  `crates/runner/tests/declared_tiers.rs`, and its `min_tier: "4b"`.
  Kettle PR #555, commit `e8d1532`, closing #554.

## Why this run was taken

`SCORING_VERSION` 15 (#554) gave one definition of whether wording is
part of a claim, and in doing so retired every tier on record — including
the 18 August M1 Pro measurement this entry's predecessor holds. The v15
rule itself was verified by **replay** over the 21 August recordings, at
no GPU cost, and that verification is what made the rule reviewable. But
a replay spawns no sidecar and so carries no wall time, and a tier is a
claim about how long a task takes on somebody's own laptop. So a tier
cannot be minted from one.

Two of Kettle's tests encode that: `app/src-tauri`'s
`the_shipped_model_keeps_each_current_pack_verdict` (#549) and the
demo's `tiers-sync.test.ts` (#554) both require the shipped model to
carry a current-version entry, and both were red on the branch until
this run existed. This is the run that made them green.

## The verdict

```
app.kttl.letter-to-actions v0.2.0 · development set · 413 fixtures · 1 run · Apple M1 Pro 32GB

model                   obligations (pooled)            e2e (mean)  review (mean)  time     verdict
qwen3.5-4b-q4_k_m.gguf  1.00 (n=509; 95% CI 0.99–1.00)  1.00        0%             107m12s  PASS

gate / any-letter / obligation      confident-wrong 0.00 (n=240; CI 0.00–0.02) <= 0.02  PASS
gate / any-letter / no_obligation   confident-wrong 0.00 (n=101; CI 0.00–0.04) <= 0.05  PASS
claim containment  4036 candidates; 1 scored decision surfaced; 0 wrong assertions escaped
guardrail / review_routing  1 failed; 1 contained; 0 escaped
relations  14 held, 0 failed, 1 unjudgeable
confidence  NO RANKING SIGNAL — every decision was declared `high`
```

`tiers.json` records `automatic 0.8889` and `wall_ms 25164`: the worst
fixture, not the mean, which is the number the screen is entitled to
quote.

## What moved against the 18 August v14 run of this same bed

Same machine, same weights, same sidecar, same fixtures, same
`--runs 1`; only the scoring changed. Compare with
`2026-08-18-letter-qwen3.5-4b-v14-tiers-m1pro/`:

| | 18 Aug, v14 | 23 Aug, v15 |
|---|---|---|
| obligations (pooled) | 0.98 (n=509; CI 0.96–0.99) | **1.00** (n=509; CI 0.99–1.00) |
| end-to-end (mean) | 0.97 | **1.00** |
| wrong assertions escaped | 24 of 4,036 | **0** of 4,036 |
| review_routing escaped | 12 | **0** |
| wall clock | 107m50s | 107m12s |

The model's answers are not being claimed to have improved: what changed
is that #554 stopped one faithful reading being counted as *found*,
*confident-wrong* and *unsupported* at once. The 24 escapes and the
0.98 were substantially that defect, which is the point the replay
verification made in seconds and this run confirms with a real timing
beside it. The wall clock moving by 38 seconds across two hours is
noise, and is the honest read on whether v15 costs anything to run.

Two things worth reading beside the verdict. The **confidence signal is
absent again** — all 478 decisions came back `high`, the fourth run in a
row where the declared level ranks nothing, which is why the tag was
removed under #519 and why `confidence-predicts-correctness` remains
unproven rather than false. And the **one unjudgeable relation** is a
controlled must-to-may pair whose obligation was routed to a person:
routing is correct behaviour, and it leaves the relation with no
assertion to judge — a property of the instrument, not a fault in the
answer.

## One thing about the conditions, stated because it could have mattered

The working tree was checked out onto another branch at 18:39 that day,
while the *subscription* run of the same sitting was still going. This
letter run finished at 17:01 and never overlapped it. In either case no
file under `packs/` differs between the two branches, so the pack
content read from disk was identical; and this recording's scoring
version is 15, which the other branch's code could not have written.
Recorded here because a recording should say what it ran under, not
because it changed anything.

## It holds this run and nothing else

`evals/runs/run1` in the working repository accumulates every eval the
machine has done, and copying it wholesale is how a MANIFEST comes to
name one run over a directory holding four. It was moved aside before
this run started, so `run1/` here is exactly the 413 fixture
directories of this bed on these weights — the development bed's own
size, which is the check that nothing is missing and nothing else crept
in.

## Provenance of the inputs

Every fixture is a committed, wholly synthetic bed letter, generated
from `packs/app.kttl.letter-to-actions/fixtures/letter-bed-spec.json`
and restorable byte-identically with `kettle bed`. Nothing here came
from a real document.
