# 2026-09-06 — app.kttl.letter-to-actions, 4B, scoring v19, development set, `--runs 3`, rented RTX 3090

- **Pack**: app.kttl.letter-to-actions 0.3.0
- **Tree**: kettle branch `625-deadline-structure` at
  `96c4ce477db7ac22c6e2a1d3ec260a3f040b02c6` (draft PR #628, over main
  `0b7127cc`): the deadline read into structure (`read`, `from`),
  the finders retired, `SCORING_VERSION` 18 → 19. No prompt, schema or
  scoring change was made on the pod.
- **Model**: qwen3.5-4b-q4_k_m.gguf (4B, Q4_K_M, context 8192), the
  file `app/src-tauri/models.json` names, pulled on the pod from the
  pinned HuggingFace URL; SHA-256
  `13c16f426047e2de38cd075bdade4a7bcbc8c774384876f677740cda65f8a983`,
  3,013,027,808 bytes, both checked against that file before anything
  ran.
- **Eval set**: development, 539 fixtures, **3 runs**
- **Scoring version**: 19 (first full run under it, and the first v19
  baseline)
- **Bed digest**: `blake3:810f8ce4ce4a636544e07cfdddc03d66fac5dd74f5dfa804e4b3820c32c89deb`
- **Sidecar**: llama-server 10145 (ad256ded), **CUDA0 (NVIDIA GeForce
  RTX 3090)**, built on the pod by `scripts/vendor-sidecar.sh` with
  `KETTLE_CUDA_ARCH=86`, `CUDA_PATH=/usr/local/cuda-12.8`;
  `libggml-cuda.so` confirmed in the vendored directory and the model
  resident on the card (3.5 GB, ~93% utilisation) before the run was
  left.
- **Machine**: **rented** — RunPod, RTX 3090, AMD Ryzen Threadripper
  PRO 3955WX 16-core, 504 GB, Ubuntu 24.04.3 LTS, CUDA 12.8.
  **This is a pod run.** Its scores compare against pod baselines only
  (#596) and never fill `tiers.json`.
- **Runtime**: context 8192, parallel 1, reasoning off, max answer
  tokens 4096
- **Recorded**: 2026-09-06T16:36:59Z (eval start); about 40 minutes a
  pass, three passes.
- **Verdict**: **FAIL** — pooled 0.82 (n=757, CI 0.79–0.84), end-to-end
  0.91, review 0%. `any-letter` obligation ceiling: confident-wrong
  over decisions 0.01 (n=251, CI 0.00–0.03) against 0.02, **FAIL** on
  the upper bound; `any-letter` no_obligation: 0.01 (n=101, CI
  0.00–0.05) against 0.05, **FAIL** on the upper bound. Relations:
  13 held, 2 failed (`reorder-holds-development-three-asks`,
  `controlled-anchor-substituted-development`). Containment: 5640
  candidates, 0 surfaced, 165 escaped.
- **Stability**: the three passes are **byte-identical** — every
  `raw/*.response*` file concatenated in path order hashes to
  `31f61830ca6e5efe463753249db99f27ebe1af2e642b792ce9cd93cf70d85705`
  in run1, run2 and run3 (539 responses each).
- **Backs**: `evals/baseline-v19-letter.json` on the #628 branch. The
  v18 → v19 delta was already known from a replay of the v18 recording
  (commit `96c4ce47`); this is the first run of the fixed tree on the
  full bed, on any backend.

## What moved against v18

The committed v18 baseline (3 September, M1 Pro Metal, PASS at 0.83
with both ceilings 0.00) is on another backend and another scoring
version, so `--baseline` refuses the comparison twice over and no
delta is claimed here. Read side by side: pooled 0.83 → 0.82, and the
two `any-letter` ceilings 0.00 → 0.01 each. The no_obligation error is
one passage — `payment_relative-dawn-41`, *"Your appointment on 12 May
was attended and the notes have been added to your record"*, read as
an attendance still to come. The obligation-side losses sit mostly in
`three-asks` (recall 0.87, n=126: *"by the end of the month"* read as
`counts_from: none` or as unit `months`, so the reply goes undated)
and one `payment-anchored` letter (`thistle-30`, deadline copied as
the bare date and left undated). Whether each is the model, the
verifier or the bed is the next sitting's question, not this
recording's.

## Provenance notes

Bed fixtures only, wholly synthetic; no private input reached the
rented machine. The repository was cloned with a read-only deploy key
generated on the pod (`runpod-3090-6sep`), never `gh auth login`.
`evals/runs` and `evals/resume` were cleared before the run;
`--runs 3` refuses `--resume` by design, so nothing was spliced.

`scripts/pod-eval.sh` stopped at its `cargo test` gate on one test,
`declared_tiers`, because `tiers.json` carries no pass under scoring
19 yet — the tiers re-measure is a separate local run, since a pod
score never fills that file. Every other test passed. The eval step
was then run by hand with the script's exact command and flags
(`eval app.kttl.letter-to-actions --model … --write-baseline … --runs 3`)
in tmux, and the tarball was brought back over the pod's exposed TCP
SSH port and verified by digest.

Timings are the pod's and are not a tier claim about anyone's laptop.
