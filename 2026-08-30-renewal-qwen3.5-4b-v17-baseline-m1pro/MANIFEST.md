# 2026-08-30 — app.kttl.renewal-diff, 4B, scoring v17, development set

- **Pack**: app.kttl.renewal-diff 0.1.0
- **Tree**: kettle branch `feature/581-gated-strata-pool` (#581 over merged PR #584)
- **Model**: qwen3.5-4b-q4_k_m.gguf (4B, Q4_K_M, context 8192), the file `app/src-tauri/models.json` names
- **Eval set**: development, 62 fixtures
- **Scoring version**: 17
- **Bed digest**: `blake3:5b52918ea896ba09d28b5e253043ffe85953e802fafb3fd9424138760e0d670e`
- **Sidecar**: llama-server 10145 (ad256ded3), Metal, device MTL0 (Apple M1 Pro)
- **Machine**: Apple M1 Pro, 32 GB
- **Runtime**: context 8192, reasoning off
- **Verdict**: PASS — pooled 0.98 (n=362, CI 0.96–0.99); both `any-schedule` ceilings clear; 5 relations held, 0 failed, 1 unjudgeable
- **Backs**: `evals/baseline-v17-renewal.json` and the `renewal-development-verdict` registry claim at scoring 17. One run on this machine; #533's `--runs 3` on the pod is still owed.

## Provenance notes

Bed fixtures only, wholly synthetic. Selected from the reused run
directory (`evals/runs/run1`) by pack prefix.
