# 2026-08-30 — app.kttl.letter-to-actions, 4B, scoring v16, development set

- **Pack**: app.kttl.letter-to-actions 0.3.0
- **Prompt tree**: 759bc55
- **Model**: qwen3.5-4b-q4_k_m.gguf (4B, Q4_K_M, context 8192)
- **Eval set**: development, 455 fixtures
- **Scoring version**: 16
- **Bed digest**: `blake3:85741a2d1dcfd451d49d0ce388ead43de100d3f2a4ad0d53750368006ac94cbc`
- **Sidecar**: llama-server 10145 (ad256ded), built from source on the pod with CUDA (`KETTLE_CUDA_ARCH=86`); device `CUDA0 (NVIDIA GeForce RTX 3090) (0000:2d:00.0)`
- **Machine**: **rented** — RunPod, NVIDIA RTX 3090, Ubuntu 24.04.3 LTS, AMD Ryzen Threadripper PRO 3955WX 16-Cores
- **Runtime**: context 8192, parallel 1, reasoning off
- **Recorded**: 2026-08-30T13:05:16Z
- **Verdict**: fail
- **Backs**: the subtractive rewrite on development. Cited in 759bc55, including the correction it carries: a local 54-fixture Metal run predicted invoice 15/24 and the full bed returned 13/24.

## Provenance notes

The weights were downloaded on the pod and verified against
`app/src-tauri/models.json`: sha256
`13c16f426047e2de38cd075bdade4a7bcbc8c774384876f677740cda65f8a983`.

The repository was delivered to the pod as a **git bundle** rather than
cloned with a deploy key — the #399 branch had never been pushed — so no
credential reached the rented machine at all.

Bed fixtures only. No `*.private.*` input, no OCR or transcript of a real
document, and no field-evidence run touched this machine.
