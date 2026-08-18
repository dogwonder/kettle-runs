# 2026-08-18 — letter pack, Qwen3.5-4B, scoring v14, on the M1 Pro

- **Pack**: app.kttl.letter-to-actions v0.2.0
- **Model**: qwen3.5-4b-q4_k_m.gguf (4B, Q4_K_M, context 8192)
- **Eval set**: development, 413 fixtures, 1 run
- **Scoring version**: 14
- **Sidecar**: llama-server 10145 (ad256ded3), Metal, bundled in `sidecars/macos-arm64/`
- **Machine**: **local** — Apple M1 Pro, 32GB, macOS 26.5.2
- **Recorded**: 2026-08-18, 107m50s wall clock
- **Verdict**: **PASS**
- **Backs**: `packs/app.kttl.letter-to-actions/tiers.json` — the file the
  model-manager screen quotes, and therefore the first claim Kettle has
  ever made about this pack on a person's own machine. Also the removal
  of the pack's staged stale floor in
  `crates/runner/tests/declared_tiers.rs`, and its `min_tier: "4b"`.

## Why this run was taken

The model-manager screen offers a download only for a model some pack
has measured as good enough, and it reads `tiers.json` for that. The
letter pack shipped none, so once the offer list was trimmed to the one
model with current evidence, **a fresh install could download nothing at
all**. The v14 numbers could not fill the gap: they were recorded on a
rented RTX 5090, and a pod timing must never be merged in as a
user-facing tier, because that sentence is a claim about somebody's own
laptop (`evals/RENTED-GPU.md`).

So this is the same pack and the same model as the 14 August pod run,
measured again on the machine the claim is about.

## The verdict

```
app.kttl.letter-to-actions v0.2.0 · development set · 413 fixtures · 1 run · Apple M1 Pro 32GB

model                   obligations (pooled)            e2e (mean)  review (mean)  time     verdict
qwen3.5-4b-q4_k_m.gguf  0.98 (n=509; 95% CI 0.96–0.99)  0.97        0%             107m50s  PASS

claim containment  4036 candidates; 24 wrong assertions escaped
guardrail / review_routing  1 failed; 1 contained; 12 escaped
relations  14 held, 0 failed, 1 unjudgeable
confidence  NO RANKING SIGNAL — every decision was declared `high`
```

`tiers.json` records `automatic 0.8889` and `wall_ms 24408`: the worst
fixture, not the mean, which is the number the screen is entitled to
quote.

Two things worth reading beside the verdict. The **confidence signal is
absent again** — every decision came back `high`, the same result the 14
August pod run gave, and the third pack in a row where the declared
level ranks nothing (`confidence-predicts-correctness` stays unproven,
and this is more evidence for the sentence being unmeasurable on this
bed rather than for it being false). And the **one unjudgeable relation**
is a controlled must-to-may pair whose obligation was routed to a
person: routing is the correct behaviour, and it leaves the relation
with no assertion to judge, which is a property of the instrument rather
than a fault in the answer.

## What it is also the control for

Issue #535 resumes the interrupted #312 prompt measurement, and asks for
a comparison against "the untouched 18 August Mac run" of this bed. This
is that run: same machine, same weights, same sidecar, same scoring, on
the **committed** prompts. Its runtime (107m50s) and output behaviour
are the "before" side of the ~20% saving #312 predicts.

`run1/` holds every fixture's recorded exchange, so the comparison — and
any future scoring change — can be re-asked by replay without spending
the machine again.

**It holds this run and nothing else.** `evals/runs/run1` in the working
repository is a shared directory that accumulates every eval the machine
has done: copying it wholesale brought 1,693 fixture directories, among
them Gemma 4 and Qwen3.5-9B recordings at other scoring versions. An
archive entry whose MANIFEST names one run over a directory holding four
is exactly the mislabelled evidence this archive exists to prevent, so
it is pruned to the 413 directories matching this pack and these
weights — the development bed's own size, which is the check that
nothing is missing and nothing else crept in.

## Provenance of the inputs

Every fixture is a committed, wholly synthetic bed letter, generated
from `packs/app.kttl.letter-to-actions/fixtures/letter-bed-spec.json`
and restorable byte-identically with `kettle bed`. Nothing here came
from a real document.
