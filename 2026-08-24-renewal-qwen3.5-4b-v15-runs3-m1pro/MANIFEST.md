# 2026-08-24 — renewal pack, Qwen3.5-4B, scoring v15, `--runs 3`, on the M1 Pro

- **Pack**: app.kttl.renewal-diff v0.1.0
- **Model**: qwen3.5-4b-q4_k_m.gguf (4B, Q4_K_M, context 8192)
- **Eval set**: development, 62 fixtures, **3 runs**
- **Scoring version**: 15
- **Bed digest**: `blake3:5b52918ea896ba09d28b5e253043ffe85953e802fafb3fd9424138760e0d670e`
- **Sidecar**: llama-server 10145 (ad256ded3), Metal, device `MTL0 (Apple M1 Pro)`
- **Runtime**: context 8192, parallel 1, **reasoning off**, max answer tokens 4096
- **Machine**: **local** — Apple M1 Pro, 32GB, macOS 26.5.2
- **Recorded**: 2026-08-24, stamped 01:50:24Z; 33m54s
- **Verdict**: **PASS**
- **Backs**: `evals/baseline-v15-renewal.json` and the assurance claim
  `renewal-development-verdict`. Kettle PR #557.

## Why this run was taken

`SCORING_VERSION` 15 (#554) is a declared invalidation trigger, so the
19 August v14 renewal baseline was refused (exit 2) and
`renewal-development-verdict` read **unproven** — the designed downgrade
rather than a regression. Nothing moved: across all 62 development
fixtures the three runs agreed on every step score, every end-to-end
score and every review rate, and validation enforces that, since a
baseline recording a moved spread downgrades its claim.

Two things changed with the machine rather than the measurement. The run
is local rather than the rented 5090 the v14 recording used, so the
**timing is this machine's** and only the scores carry over — this is
the first of the two live claims to stand on Metal. And the sidecar
string moved from `10145 (ad256ded)` to `10145 (ad256ded3)`: the same
llama.cpp build printed with one more character of its hash, which the
exact-match content check (#489) reads as a change. Recorded so the next
reader does not take it for one.

## Why it was archived late

It was not archived when it was taken. It was found on 24 August, still
sitting in the un-renamed default run slots (`evals/runs/run1`–`run3`)
where the next `kettle eval` would have overwritten it — a live claim's
only recording, one command from gone, in a gitignored directory with no
undo.

The retention rule already covered it ("a run is archived here if a
committed baseline **or a cited finding** stands on it"), so this is the
rule being missed rather than the rule being too narrow. The same sweep
found that the 9B and 27B subscription auditions behind the bench's
monotonic knowledge-up / harm-up finding were never archived either and
are now unrecoverable, which is what prompted looking. Recorded here
because "archived before cleanup" is only a discipline if a lapse gets
written down rather than quietly fixed.

## What it is also the evidence for

The renewal half of the #432 ablation re-read at v15 (24 August): 363
claims carry a verdict of 1,132 recorded, **8 escaped on every rung**
and 0 demonstrably prevented, unchanged from the v14 reading. All eight
are the `excess_unqualified` stratum — two claims each in `garnet-01`,
`hazel-02`, `iris-03` and `juniper-04` — and every guardrail passes on
them, because the quote is exact, contains its value and identifies its
passage. What is wrong is the term's *label*, which no quote-shaped rule
can reach by construction. That is the registry's already-failed
`ambiguous-term-referred` claim, and #461 names the missing mechanism.

Replay it with:

```sh
kettle ablate --baseline evals/baseline-v15-renewal.json --runs <this dir>/run1
```

## Confidence, recorded because it is a property this claim does not assert

The confidence signal on this pack remains **inverted**: `high` errs at
0.02 over 331 decisions where `low` errs at 0.00 over 339, so routing
the less confident decisions to review spends the review on the wrong
ones (#429). The claim this run backs neither asserts nor needs that.
