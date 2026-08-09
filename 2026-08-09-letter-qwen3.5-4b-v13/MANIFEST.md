# 2026-08-09 — letter pack, Qwen3.5-4B, scoring v13

- **Pack**: app.kttl.letter-to-actions 0.2.0
- **Model**: qwen3.5-4b-q4_k_m.gguf (4B, Q4_K_M, context 8192)
- **Eval set**: development, 366 fixtures
- **Scoring version**: 13
- **Bed digest**: blake3:732f544e078f656a9540c415d025eaa082088120d0f583b43d99346ae3d29b1d
- **Sidecar**: llama-server 10145 (ad256ded3), reasoning off
- **Machine**: Apple M1 Pro, 32GB, macOS 26.5
- **Recorded**: 2026-08-09 (baseline stamped 12:11:18Z at run start)
- **Backs**: `evals/baseline-v13-letter.json` in kettle (committed via
  PR #467) — verdict PASS: 0 confident-wrong in 207 obligation and 85
  no-obligation gated decisions; 11 relations held.
- **Provenance**: run in the `434-assurance-claims` worktree, this
  repo's first fresh v13 measurement. Recordings are verbatim
  `evals/runs/run1` from that run.
