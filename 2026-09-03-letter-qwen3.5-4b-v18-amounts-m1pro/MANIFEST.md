# 2026-09-03 — app.kttl.letter-to-actions, 4B, scoring v18, development set (#612 amounts)

- **Pack**: app.kttl.letter-to-actions 0.3.0
- **Tree**: kettle branch `612-amounts` at `949a2e2` (PR #619, over `614-conditional-done` `40eb0ba`, PR #617): the `amount` field in schema, prompt and bed; the #614 already-done conditionals and `conditional-done` stratum; prompts otherwise as main `615e2f8`
- **Model**: qwen3.5-4b-q4_k_m.gguf (4B, Q4_K_M, context 8192), the file `app/src-tauri/models.json` names
- **Eval set**: development, 539 fixtures
- **Scoring version**: 18 (first measurement under it — the sum is part of the obligation, #612)
- **Bed digest**: `blake3:f33a4232756f39282279ba9d85210c9478d1c76189f6a9c5bfe83b93a76ea861`
- **Sidecar**: llama-server 10145 (ad256ded3), Metal, device MTL0 (Apple M1 Pro)
- **Machine**: Apple M1 Pro, 32 GB
- **Runtime**: context 8192, reasoning off
- **Recorded**: 2026-09-03T20:54:20Z
- **Verdict**: PASS — pooled 0.83 (n=725, CI 0.80–0.85), end-to-end 0.90; both `any-letter` ceilings 0.00 (obligation n=240, no_obligation n=101). The 4B copied the sum correctly on all 642 obligations it found.
- **Backs**: `evals/baseline-v18-letter.json` and the letter rows of `packs/app.kttl.letter-to-actions/tiers.json` at scoring 18. One run on this machine. The weekly pod run (3 September decision) is the cross-check.

## Provenance notes

Bed fixtures only, wholly synthetic. A first v18 run earlier the same
evening FAILed its obligation gate on eleven passive-voice payment
decisions whose *expectation* carried the sentinel while the passage
printed the sum and the model copied it — a bed defect, fixed in
`949a2e2` and not archived. `evals/runs/run1` is reused across sittings;
this entry carries exactly the 539 recordings of the committed bed,
selected by the baseline's own fixture list.
