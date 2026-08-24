# 2026-08-24 — letter pack, Qwen3.5-4B, scoring v15, `--runs 3`, on a rented RTX 3090

- **Pack**: app.kttl.letter-to-actions v0.2.0
- **Model**: qwen3.5-4b-q4_k_m.gguf (4B, Q4_K_M, context 8192)
  — verified on the pod against `app/src-tauri/models.json`:
  3,013,027,808 bytes, SHA-256
  `13c16f426047e2de38cd075bdade4a7bcbc8c774384876f677740cda65f8a983`
- **Eval set**: development, 413 fixtures, **3 runs**
- **Scoring version**: 15
- **Bed digest**: `blake3:57b37e87570cc6612fbaa96c1e633e2382b5ea2dedbf997a6d83a0c89df4826a`
- **Sidecar**: llama-server 10145 (ad256ded), **CUDA0 (NVIDIA GeForce RTX 3090)**,
  built on the pod from the pinned tag with `KETTLE_CUDA_ARCH=86`
- **Runtime**: context 8192, parallel 1, **reasoning off**, max answer tokens 4096
- **Machine**: **rented** — AMD EPYC 7H12 64-core, 1008GB RAM, Ubuntu 24.04.3 LTS,
  RTX 3090, RunPod eu-cz-1
- **Recorded**: 2026-08-24, 23m15s per pass
- **Verdict**: **PASS**
- **Backs**: `evals/baseline-v15-letter.json` and the assurance claim
  `letter-harm-ceilings`. Kettle PR #558.

## Why this run was taken

`SCORING_VERSION` 15 (#554) is a declared invalidation trigger, so the
21 August v14 letter baseline was refused (exit 2) and
`letter-harm-ceilings` read **unproven** — the designed downgrade, not a
break. A replay can re-score the recording it replaces but must not mint
a baseline: it spawns no sidecar and carries no runtime.

`--runs 3` because #533 asks a claim-backing baseline to carry a
stability check, and three letter beds are ~70 minutes here against
~5.4 hours on the M1 Pro. That is the whole case for renting a box.

## The verdict

```
app.kttl.letter-to-actions v0.2.0 · development set · 413 fixtures · 3 runs · RTX 3090

model                   obligations (pooled)            e2e (mean)  review (mean)  time     verdict
qwen3.5-4b-q4_k_m.gguf  1.00 (n=509; 95% CI 0.99–1.00)  1.00        0%             23m15s   PASS

gate / any-letter / obligation      confident-wrong 0.00 (n=240; CI 0.00–0.02) <= 0.02  PASS
gate / any-letter / no_obligation   confident-wrong 0.00 (n=101; CI 0.00–0.04) <= 0.05  PASS
claim containment  4036 candidates; 1 scored decision surfaced; 0 wrong assertions escaped
relations  14 held, 0 failed, 1 unjudgeable (routed to a person)
confidence  NO RANKING SIGNAL — every decision was declared `high`
```

**The three runs agreed on everything.** All 413 fixtures reported an
identical low and high on every step score, end-to-end score and review
rate. Validation enforces it: a baseline recording a moved spread
downgrades its claim.

## What this recording also measures

`evals/RENTED-GPU.md` names one experiment it had never run — *"the same
commit, bed and weights on both machines"* — because score equivalence
across backends is asserted there and never measured, while timings are
known to be machine-bound.

This run and `2026-08-23-letter-qwen3.5-4b-v15-tiers-m1pro/` are that
experiment, taken a day apart without planning to be: same commit, same
bed digest, same weights SHA-256, same pinned sidecar tag, same scoring
version. Different backend (CUDA against Metal), card, and CPU.

| | M1 Pro, Metal | RTX 3090, CUDA |
|---|---|---|
| extraction strata compared | 56 | 56 |
| strata differing | — | **0** |
| obligations (pooled) | 1.00 (n=509) | 1.00 (n=509) |
| harm gates | 0.00 / 0.00 | 0.00 / 0.00 |
| escaped of 4,036 candidates | 0 | 0 |
| wall clock per pass | 107m12s | **23m15s** |

Every comparable stratum reports identical precision on identical
denominators. One pack on one bed is not a general law, but the sentence
in `RENTED-GPU.md` is no longer only a sentence. The **timings are not
equivalent** and never were — 4.6× apart — which is exactly why a pod
timing must never be merged into `tiers.json` as a user-facing tier.

Note the M1 Pro side of that comparison was `--runs 1` and this is
`--runs 3`; the scores compared are the reported (worst) run in each
case.

## What this run cost to get right

Two faults, both specific to a card that is **not** the RTX 5090
`RENTED-GPU.md` was written on, and both caught before they spoiled
anything:

1. **The sidecar built CPU-only.** `vendor-sidecar.sh` decides with
   `command -v nvcc`, and RunPod's PyTorch image ships the toolkit at
   `/usr/local/cuda/bin` without putting it on `PATH`. The script took
   the CPU branch and said so on stderr — correct behaviour and a
   correct message, invisible to a log filtered for failure words. Fixed
   with `export PATH=/usr/local/cuda/bin:$PATH`; the log then reads
   `building b10145 with CUDA=ON`.
2. **The CUDA architecture default is Blackwell.**
   `-DCMAKE_CUDA_ARCHITECTURES=${KETTLE_CUDA_ARCH:-120}` is `sm_120`; a
   3090 is Ampere, `sm_86`. Building 120 and running on Ampere dies at
   runtime with no kernel image, after the full compile. Fixed with
   `KETTLE_CUDA_ARCH=86`.

That `CUDA=ON` at build time still does not prove the GPU ran the model
was checked separately: `nvidia-smi` showed the model resident in
3,574 MiB of VRAM at 92% utilisation and ~340W while fixtures scored. A
first reading of 0% taken during model load meant nothing.

Both are written up in `evals/RENTED-GPU.md` under PR #558.

## It holds this run and nothing else

The pod was provisioned for this run alone, so `evals/runs/run1` there
contains only this bed on these weights: exactly 413 fixture
directories, the development bed's own size, which is the check that
nothing is missing and nothing else crept in.

## Provenance of the inputs

Every fixture is a committed, wholly synthetic bed letter, generated
from `packs/app.kttl.letter-to-actions/fixtures/letter-bed-spec.json`
and restorable byte-identically with `kettle bed`. Nothing here came
from a real document, and nothing derived from one was ever copied to
the rented machine — `pod-eval.sh` takes a pack id and offers no
`--fixture-dir`, so no argument exists through which a private path
could reach it.
