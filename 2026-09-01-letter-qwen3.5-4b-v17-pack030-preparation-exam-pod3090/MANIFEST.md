# 2026-09-01 — app.kttl.letter-to-actions, 4B, scoring v17, **exam** set (#399 appointment_preparation)

- **Pack**: app.kttl.letter-to-actions 0.3.0
- **Tree**: kettle `4b881668b3408f9236d09ec7f25e15e8798e5107` (content-identical to main's `89ba066`, #589)
- **Model**: qwen3.5-4b-q4_k_m.gguf (4B, Q4_K_M, context 8192)
- **Eval set**: **exam**, 515 fixtures
- **Scoring version**: 17
- **Bed digest**: `blake3:21b7a2f6ad47c56ed5e81eef4da4eb7abc861610c1cb4ef96889596b125abb7b`
- **Sidecar**: llama-server 10145 (ad256ded), **CUDA0 (NVIDIA GeForce RTX 3090)**, `CMAKE_CUDA_ARCHITECTURES=86`
- **Machine**: rented RTX 3090, AMD EPYC 7H12 64-Core, 1008 GB, Ubuntu 24.04.3
- **Runtime**: context 8192, `--parallel 1`, reasoning off, `--threads 64`
- **Recorded**: 2026-09-01T19:35:53Z
- **Verdict**: FAIL on the exam pooled bar — pooled 0.85 (n=701, CI 0.82–0.88), end-to-end 0.88.
- **Backs**: the answer to the risk `a62db28` pre-registered and shipped without measuring.

## What this run was for

`a62db28`'s commit message named a specific danger *before* the prompt
shipped, and could not afford to test it — a full exam run was two
hours of local GPU:

> exam's `request_unresolvable` asks *"We would be grateful **if you
> could** send a meter reading"*, 31 expected obligations, where
> development says plainly *"Please send us a meter reading"*. A model
> applying the new rule to that "if" converts 31 obligations into
> misses.

**It did not happen.** `request-unresolvable` obligation recall
**1.00 (n=31)**, confident-wrong 0.00; `unresolvable-deadline`
**1.00 (n=31)**, confident-wrong 0.00. All 31 intact. The follow-up
clause — *a polite softening is not a condition* — cost 0.03
end-to-end on development and was taken on the harm asymmetry alone.
This is the run that earns it.

## The exam voice is harder in both directions

| stratum | development | exam |
|---|---|---|
| `preparation-ask` recall | 0.13 | 0.35 |
| `compound-ask` recall | 0.05 | 0.13 |
| `attendance-manner` inventions | 29/120 | 62/120 |

Exam states its asks deontically (`You must …`) where development is
polite (`Please …`), and the model records more of everything —
correct and incorrect alike. The shape holds mood constant *within*
each voice, so each column is internally valid and the gap between
them is real rather than an artefact. The compound sentence costs a
third of the asks in development and two thirds in exam: joining the
clauses hurts more where the ask is stated more forcefully.

## Provenance notes

Bed fixtures only, wholly synthetic. `evals/runs` and `evals/resume`
both cleared; the run asserts its own completeness (515 asked, 515
recorded). Read `sidecar.device` before comparing with any Metal run —
see #596 and the development manifest beside this one.

Timings are the pod's and are not a tier claim about anyone's laptop.
