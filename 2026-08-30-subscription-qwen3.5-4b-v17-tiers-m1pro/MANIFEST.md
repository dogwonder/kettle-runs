# 2026-08-30 — app.kttl.subscription-audit, 4B, scoring v17, development set

- **Pack**: app.kttl.subscription-audit 1.5.0 (withdrawn from the product, #545 — measured in the lab)
- **Tree**: kettle branch `feature/581-gated-strata-pool`
- **Model**: qwen3.5-4b-q4_k_m.gguf (4B, Q4_K_M, context 8192), the file `app/src-tauri/models.json` names
- **Eval set**: development, 86 fixtures
- **Scoring version**: 17
- **Sidecar**: llama-server 10145 (ad256ded3), Metal, device MTL0 (Apple M1 Pro)
- **Machine**: Apple M1 Pro, 32 GB
- **Runtime**: context 8192, reasoning off
- **Verdict**: FAIL — 0.69 (n=900), where it has sat since v14. The pack declares no gated strata change; the #581 rule does not move it.
- **Backs**: the subscription rows of `packs/app.kttl.subscription-audit/tiers.json` at scoring 17 — the model-manager evidence that the shipped model does not clear this pack, quoted by the app as the reason the pack has no tier.

## Provenance notes

Bed fixtures only, wholly synthetic (invented merchants plus public
brand names as descriptor text, per the data rules). Selected from the
reused run directory by pack prefix.
