# 2026-09-01 — app.kttl.letter-to-actions, 4B, scoring v17, development set (#399 appointment_preparation)

- **Pack**: app.kttl.letter-to-actions 0.3.0
- **Tree**: kettle `4b881668b3408f9236d09ec7f25e15e8798e5107`, the branch
  `399-appointment-confirmed` as pushed; identical in content to main's
  squash `89ba066` (#589). Adds the `appointment_preparation` shape
  (240 fixtures, 60 families a set, two layouts) and
  `crates/runner/tests/reading_vocabulary.rs`.
- **Model**: qwen3.5-4b-q4_k_m.gguf (4B, Q4_K_M, context 8192), the file
  `app/src-tauri/models.json` names, pulled on the pod from the pinned
  HuggingFace URL and verified against the sha256 that file records.
- **Eval set**: development, 539 fixtures
- **Scoring version**: 17
- **Bed digest**: `blake3:fa51cc597925476b09ff0a6d9c36075f5bf20ae68a77856138b0b0ad436067bd`
- **Sidecar**: llama-server 10145 (ad256ded), **CUDA0 (NVIDIA GeForce RTX 3090)**, built on this host by `scripts/vendor-sidecar.sh` with `CMAKE_CUDA_ARCHITECTURES=86`
- **Machine**: rented RTX 3090, AMD EPYC 7H12 64-Core, 1008 GB, Ubuntu 24.04.3
- **Runtime**: context 8192, `--parallel 1`, reasoning off, `--threads 64`
- **Recorded**: 2026-09-01T18:48:01Z
- **Verdict**: PASS — pooled 0.83 (n=725, CI 0.81–0.86), end-to-end 0.89.
  Ungated strata: `preparation-ask` recall 0.13, `compound-ask` 0.05,
  `attendance-manner` 29 inventions in 120, `appointment-confirmed`
  24/24. `absolute-deadline` recall 0.94 (n=191).
- **Backs**: the #399 finding that a preparation ask joined to a manner
  clause in one sentence is read far worse than the same ask as its own
  passage, and one half of #596's cross-runtime comparison.

## Read the backend before comparing this to anything

**This run is not interchangeable with a Metal run.** Measured the same
day (#596): over 852 passages of 84 shared fixtures, two runs on this
box were byte-identical (0 differences, twice, with `evals/runs` and
`evals/resume` cleared between), and thread count changed nothing
(64 against 5, 0 differences) — but M1 Pro Metal against this CUDA box
differed on **53 passages (6.2%)**, 32 of them flipping whether an
obligation exists at all.

So within a runtime this pipeline is exactly reproducible, and across
runtimes it is not. `sidecar.device` in `baseline.json` is the field
that matters when comparing, not a footnote about timing.

## Provenance notes

Bed fixtures only, wholly synthetic; no private input reached the
rented machine, and the repository arrived as a `git bundle` of
committed history rather than through a credential.

`evals/runs` **and** `evals/resume` were cleared before this run. That
is not routine hygiene: an earlier attempt the same day built a
CPU-only sidecar, scored 33 fixtures and was killed; the relaunch
cleared only `evals/runs`, and `--resume` — which keys on model, pack
version, bed digest and scoring version but **not** the sidecar —
spliced 32 CPU-generated answers into a CUDA run that reported "539
fixtures" and had 507 directories. That spliced run is **not** archived
(#596). This one asserts its own completeness: 539 asked, 539 recorded.

Timings are the pod's and are not a tier claim about anyone's laptop.
