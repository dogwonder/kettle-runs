# 2026-08-30 — app.kttl.subscription-audit, 4B, scoring v16, exam set

- **Pack**: app.kttl.subscription-audit 1.5.0
- **Prompt tree**: 759bc55 branch tree (subscription pack byte-identical to main)
- **Model**: qwen3.5-4b-q4_k_m.gguf (4B, Q4_K_M, context 8192)
- **Eval set**: exam, 81 fixtures
- **Scoring version**: 16
- **Bed digest**: `blake3:2d32013a08f25fdae34258b9696b0996fd1ed959c1b9a7592a7669817c41d933`
- **Sidecar**: llama-server 10145 (ad256ded), built from source on the pod with CUDA (`KETTLE_CUDA_ARCH=86`); device `CUDA0 (NVIDIA GeForce RTX 3090) (0000:2d:00.0)`
- **Machine**: **rented** — RunPod, NVIDIA RTX 3090, Ubuntu 24.04.3 LTS, AMD Ryzen Threadripper PRO 3955WX 16-Cores
- **Runtime**: context 8192, parallel 1, reasoning off
- **Recorded**: 2026-08-30T12:56:11Z
- **Verdict**: fail
- **Backs**: the subscription pack's first exam measurement at any version: normalise 514/809 = 0.635, worse than development, the same voice divergence #552 found in the letter pack.

## Provenance notes

The weights were downloaded on the pod and verified against
`app/src-tauri/models.json`: sha256
`13c16f426047e2de38cd075bdade4a7bcbc8c774384876f677740cda65f8a983`.

The repository was delivered to the pod as a **git bundle** rather than
cloned with a deploy key — the #399 branch had never been pushed — so no
credential reached the rented machine at all.

Bed fixtures only. No `*.private.*` input, no OCR or transcript of a real
document, and no field-evidence run touched this machine.
