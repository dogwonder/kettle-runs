# 2026-08-30 — app.kttl.letter-to-actions, 4B, scoring v17, development set

- **Pack**: app.kttl.letter-to-actions 0.3.0
- **Tree**: kettle branch `feature/581-gated-strata-pool` (the #581 scoring change over merged PR #584); prompts unchanged from main `8e58b27`
- **Model**: qwen3.5-4b-q4_k_m.gguf (4B, Q4_K_M, context 8192), the file `app/src-tauri/models.json` names
- **Eval set**: development, 425 fixtures
- **Scoring version**: 17 (first measurement under it — the pooled verdict reads the gated strata only, #581)
- **Bed digest**: `blake3:4b84b701735475ab9987398f71b5aa96ec98824520fe355e10f4e50058a7a34f`
- **Sidecar**: llama-server 10145 (ad256ded3), Metal, device MTL0 (Apple M1 Pro)
- **Machine**: Apple M1 Pro, 32 GB
- **Runtime**: context 8192, reasoning off
- **Recorded**: 2026-08-30T18:06:48Z
- **Verdict**: PASS — pooled 0.98 (n=521, CI 0.97–0.99); both `any-letter` ceilings 0.00. `invoice-totals` (24 obligation decisions) is out of the pool for the first time, as #508 declared and #581 enforced.
- **Backs**: `evals/baseline-v17-letter.json` and the letter rows of `packs/app.kttl.letter-to-actions/tiers.json` at scoring 17. One run on this machine; #533's `--runs 3` on the pod is still owed.

## Provenance notes

Bed fixtures only, wholly synthetic. The run directory kettle wrote
(`evals/runs/run1`) is reused across sittings and held stale entries,
including thirty `conditional_advisory` recordings from a 455-fixture
branch bed; this entry carries exactly the 425 recordings of the
committed bed, selected by the baseline's own fixture list.
