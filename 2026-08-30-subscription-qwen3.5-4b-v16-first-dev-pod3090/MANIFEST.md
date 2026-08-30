# 2026-08-30 — app.kttl.subscription-audit, 4B, scoring v16, development set

- **Pack**: app.kttl.subscription-audit 1.5.0
- **Prompt tree**: 759bc55 branch tree (subscription pack byte-identical to main)
- **Model**: qwen3.5-4b-q4_k_m.gguf (4B, Q4_K_M, context 8192)
- **Eval set**: development, 86 fixtures
- **Scoring version**: 16
- **Bed digest**: `blake3:43b888e7b65ed9286fb65ab75f4f53849ac8490ae3e31a36070c5e3fd54e82da`
- **Sidecar**: llama-server 10145 (ad256ded), built from source on the pod with CUDA (`KETTLE_CUDA_ARCH=86`); device `CUDA0 (NVIDIA GeForce RTX 3090) (0000:2d:00.0)`
- **Machine**: **rented** — RunPod, NVIDIA RTX 3090, Ubuntu 24.04.3 LTS, AMD Ryzen Threadripper PRO 3955WX 16-Cores
- **Runtime**: context 8192, parallel 1, reasoning off
- **Recorded**: 2026-08-30T12:30:26Z
- **Verdict**: fail
- **Recordings**: assembled from two invocations — see the note below
- **Backs**: the subscription pack's first measurement at scoring 16: normalise 629/900 = 0.699 against a 0.85 bar. v14 measured 623/900 = 0.692, so the gap is long-standing rather than new.

## Provenance notes

The weights were downloaded on the pod and verified against
`app/src-tauri/models.json`: sha256
`13c16f426047e2de38cd075bdade4a7bcbc8c774384876f677740cda65f8a983`.

The repository was delivered to the pod as a **git bundle** rather than
cloned with a deploy key — the #399 branch had never been pushed — so no
credential reached the rented machine at all.

Bed fixtures only. No `*.private.*` input, no OCR or transcript of a real
document, and no field-evidence run touched this machine.

## How these recordings were assembled, which is not the usual way

85 of the 86 recordings here were produced by an **earlier invocation of
this same measurement that was refused at the recording step**, and one
— `statement-04.pdf` — by the invocation that produced the baseline.

The first attempt ran without a PDF reader. `#256` refused to record it,
correctly: it could read 80-odd of 81 development fixtures and a run
that could not read the whole bed is not a measurement of the bed. The
second attempt added pdfium and `--features pdf`, and `--resume` served
the 85 already-scored fixtures from the cache rather than re-asking
them, so only the PDF fixture wrote a fresh run directory.

The 85 are therefore genuinely the answers this baseline was computed
from — the resume key includes pack, pack version, prompt digest, model,
sidecar, scoring version, eval set and fixture digest, and every one of
those was identical across the two attempts; only the binary's PDF
feature differed, which cannot affect a CSV fixture. Verified by name:
all 86 baseline fixtures match a recording, with none left over on
either side.

They were briefly filed under the caveat-dev letter entry, because they
were still sitting in the shared `evals/runs/run1` when the next letter
run began. Moved here on the day, before this repository was pushed.

The avoidable part is the harness: a run directory shared across
sequential evals, cleared after archiving rather than before each run,
puts one measurement's recordings inside another's tarball. Clearing
before each run is the fix, and the scripts for this sitting now do.
