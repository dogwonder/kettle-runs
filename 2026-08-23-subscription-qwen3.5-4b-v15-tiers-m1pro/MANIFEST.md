# 2026-08-23 — subscription pack, Qwen3.5-4B, scoring v15, on the M1 Pro

- **Pack**: app.kttl.subscription-audit v1.5.0
- **Model**: qwen3.5-4b-q4_k_m.gguf (4B, Q4_K_M, context 8192)
- **Eval set**: development, 84 fixtures, 1 run
- **Scoring version**: 15
- **Bed digest**: `blake3:f3512515b617df26e920f749ac342ee10e649fc10593277ff70fbdbd93c68f35`
- **Sidecar**: llama-server 10145 (ad256ded3), Metal (MTL0), bundled in `sidecars/macos-arm64/`
- **Runtime**: context 8192, parallel 1, **reasoning off**, max answer tokens 4096
- **Machine**: **local** — Apple M1 Pro, 32GB, macOS 26.5.2
- **Recorded**: 2026-08-23, 37m13s wall clock
- **Verdict**: **FAIL**
- **Backs**: the v15 entry in `packs/app.kttl.subscription-audit/tiers.json`
  and the updated reason on the pack's entry in `STAGED_STALE_FLOORS`.
  Kettle PR #555, commit `e8d1532`, closing #554.

## Why a failing run is archived

Because the failure is the claim. `app/src-tauri`'s
`the_shipped_model_keeps_each_current_pack_verdict` (#549) asserts two
things about the shipped model: that the letter measurement is
good-enough, **and that the statement measurement is present and not**.
Decision #52's rule is that a model a pack scored FAIL stays visible —
deleting it would hide the evidence — so the screen needs a current
failing entry as much as it needs a current passing one. Without this
run the test cannot distinguish "measured and not good enough" from
"never measured", which is the distinction the whole tiers mechanism
exists to keep.

It also changes what the pack's staged stale floor says. Before this
run, the stage stood because there was no current-scoring measurement at
all. Now there is one and it fails, so the floor is stale **for want of
a pass, not for want of a measurement** — a weaker and more honest
statement, recorded in `declared_tiers.rs` rather than remembered.

## The verdict

```
app.kttl.subscription-audit v1.5.0 · development set · 84 fixtures · 1 run · Apple M1 Pro 32GB

model                   normalise (pooled)              e2e (mean)  review (mean)  time    verdict
qwen3.5-4b-q4_k_m.gguf  0.69 (n=900; 95% CI 0.66–0.72)  1.00        39%             37m13s  FAIL

classification / harm / subscription      precision 1.00 (n=291); recall 0.97 (n=488); confident-wrong 0.03
classification / harm / not_subscription  precision 0.94 (n=250); recall 1.00 (n=411); confident-wrong 0.00
classification / kind / regular_spend     precision 0.19 (n=16); recall 0.96 (n=91)
claim containment  1800 candidates; 358 scored decisions surfaced; 153 wrong assertions escaped
guardrail / review_routing  0 failed; 358 contained; 0 escaped
relations  0 held, 0 failed, 4 unjudgeable
```

**Every ceiling on this pack reads UNPROVEN, not PASS.** The pooled
`any-statement / subscription` gate needs 73 distinct decisions and this
bed yields 32; the three per-stratum ceilings yield eight each. So the
FAIL is the pack's step threshold on `normalise`, and the harm ceilings
say nothing either way — which is #310's rule working, not a gap to
paper over. The `regular_spend` precision of 0.19 is the loudest
diagnostic here, and it is a classification-boundary problem rather than
a reading one.

**Confidence ranks on this pack**, unlike the letter bed: `high` errs at
0.10 (n=49), `medium` at 0.50 (n=12), `low` routes all 39 of its
decisions to review. A further 67 decisions are `untraceable` — no
single declared level answered for them, counted and never assigned.
That it ranks here and gives no signal at all on letters is the finding
#429 closed on, and this is another instance of it.

The **four unjudgeable relations** all trace to one fixture whose
decision was routed to a person: routing is correct behaviour and leaves
no assertion to judge. Zero relations held on this run — not because any
failed, but because nothing was judgeable.

## The 153 escapes are not new

`claim guardrail / schema` and `pairing` each report 153 escaped and 0
contained. That is #432's scorecard finding on this pack reproduced at
v15, not a regression introduced by the scoring change: the quote rules
have no gate path on this pack's shapes at these denominators. Read it
beside `2026-08-14-subscription-qwen3.5-4b-v14-baseline-pod5090/`.

## One thing about the conditions

The working tree was checked out onto another branch at 18:39, roughly
ten minutes before this run finished at 18:49 — another session's work,
not a change made for this run. It did not affect the recording: no file
under `packs/` differs between the two branches, so the pack content
read from disk was identical throughout, the binary was built before the
switch and never rebuilt, and the resulting entry records
`scoring_version: 15`, which the other branch's code could not write.
Recorded here because the conditions of a run belong in its manifest
even when they turn out not to have mattered.

## It holds this run and nothing else

`evals/runs/run1` was moved aside before this run started, so `run1/`
here is exactly the 84 fixture directories of this bed on these weights
— the development bed's own size, which is the check that nothing is
missing and nothing else crept in.

## Provenance of the inputs

Every fixture is a committed, wholly synthetic statement, generated from
`packs/app.kttl.subscription-audit/fixtures/eval-bed-spec.json` and
restorable byte-identically with `kettle bed`. Merchant descriptors may
name real public brands (a company's own trading name discloses nothing
about any person) alongside a long tail of invented, unknowable
merchants; no row is traceable to a person, and nothing here came from a
real document.
