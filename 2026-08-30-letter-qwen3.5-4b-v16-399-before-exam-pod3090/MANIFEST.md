# 2026-08-30 — app.kttl.letter-to-actions, 4B, scoring v16, exam set

- **Pack**: app.kttl.letter-to-actions 0.3.0
- **Prompt tree**: 6030583 (main's obligations prompt on the #399 bed)
- **Model**: qwen3.5-4b-q4_k_m.gguf (4B, Q4_K_M, context 8192)
- **Eval set**: exam, 443 fixtures
- **Scoring version**: 16
- **Bed digest**: `blake3:6299964af60debbf0e8a6668533fc8b907b41a0dba5ab8b7e71ad0e05b407874`
- **Sidecar**: llama-server 10145 (ad256ded), built from source on the pod with CUDA (`KETTLE_CUDA_ARCH=86`); device `CUDA0 (NVIDIA GeForce RTX 3090) (0000:2d:00.0)`
- **Machine**: **rented** — RunPod, NVIDIA RTX 3090, Ubuntu 24.04.3 LTS, AMD Ryzen Threadripper PRO 3955WX 16-Cores
- **Runtime**: context 8192, parallel 1, reasoning off
- **Recorded**: 2026-08-30T10:37:14Z
- **Verdict**: fail
- **Backs**: the first exam-set measurement of the letter pack at any scoring version — every committed baseline v11..v16 is development-only. It shows main already failing any-letter/obligation by a single miss (1 in 252, Wilson high 0.0221 against 0.02).

## Provenance notes

The weights were downloaded on the pod and verified against
`app/src-tauri/models.json`: sha256
`13c16f426047e2de38cd075bdade4a7bcbc8c774384876f677740cda65f8a983`.

The repository was delivered to the pod as a **git bundle** rather than
cloned with a deploy key — the #399 branch had never been pushed — so no
credential reached the rented machine at all.

Bed fixtures only. No `*.private.*` input, no OCR or transcript of a real
document, and no field-evidence run touched this machine.
