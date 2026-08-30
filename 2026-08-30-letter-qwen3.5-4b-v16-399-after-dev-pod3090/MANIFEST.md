# 2026-08-30 — app.kttl.letter-to-actions, 4B, scoring v16, development set

- **Pack**: app.kttl.letter-to-actions 0.3.0
- **Prompt tree**: 0e570d2
- **Model**: qwen3.5-4b-q4_k_m.gguf (4B, Q4_K_M, context 8192)
- **Eval set**: development, 455 fixtures
- **Scoring version**: 16
- **Bed digest**: `blake3:85741a2d1dcfd451d49d0ce388ead43de100d3f2a4ad0d53750368006ac94cbc`
- **Sidecar**: llama-server 10145 (ad256ded), built from source on the pod with CUDA (`KETTLE_CUDA_ARCH=86`); device `CUDA0 (NVIDIA GeForce RTX 3090) (0000:2d:00.0)`
- **Machine**: **rented** — RunPod, NVIDIA RTX 3090, Ubuntu 24.04.3 LTS, AMD Ryzen Threadripper PRO 3955WX 16-Cores
- **Runtime**: context 8192, parallel 1, reasoning off
- **Recorded**: 2026-08-30T11:02:11Z
- **Verdict**: fail
- **Backs**: the conditional/advisory prompt work measured on the full development bed: 73 wrong assertions down to 19, and nine invoice_totals regressions it also caused.

## Provenance notes

The weights were downloaded on the pod and verified against
`app/src-tauri/models.json`: sha256
`13c16f426047e2de38cd075bdade4a7bcbc8c774384876f677740cda65f8a983`.

The repository was delivered to the pod as a **git bundle** rather than
cloned with a deploy key — the #399 branch had never been pushed — so no
credential reached the rented machine at all.

Bed fixtures only. No `*.private.*` input, no OCR or transcript of a real
document, and no field-evidence run touched this machine.
