# 2026-08-11 — renewal pack, Qwen3.5-4B, scoring v13, Phase 2 bed

- **Pack**: app.kttl.renewal-diff 0.1.0
- **Model**: qwen3.5-4b-q4_k_m.gguf (4B, Q4_K_M, context 8192)
- **Eval set**: development, 54 fixtures
- **Scoring version**: 13
- **Bed digest**: blake3:922f16d488daffa776c6477477639404d6469f26f76c9382e5c223c151d9723e
- **Sidecar**: llama-server 10145 (ad256ded3)
- **Runtime policy**: context 8192, parallel 1, reasoning off, max answer
  tokens 4096 — the first renewal recording to carry one (#232).
- **Machine**: Apple M1 Pro, 32GB, macOS 26.5.2
- **Recorded**: 2026-08-11, 08:44:42Z at run start, 30m36s
- **Backs**: `evals/baseline-v13-renewal.json` in kettle — verdict PASS:
  step score 1.00 pooled over 330 decisions, e2e 1.00, review 1%, both
  harm gates 0.00 confident-wrong (302 obligation and 329 no_obligation
  gated decisions), 0 wrong assertions escaped from 1020 candidates,
  5 relations held and 1 unjudgeable.
- **Provenance**: the Phase 2 close-out run of PLAN-M7's renewal cluster,
  run on branch `468-cover-limit-label-family`. It measures three changes
  together — #468's cover-limit vocabulary edit, #460's quote
  instruction, and the settled bed (#462's decided outcomes, #461's
  ambiguity referral, #433's delimiter family).

**This recording measures a level, not a delta.** The bed digest moved in
the same commits as the prompt edits, so the harness refused the
comparison against the previous baseline (blake3:c438a0df…) under #320
and exited 2. "Nothing got worse than the baseline" is printed beneath
that refusal by the report's own layout and is unearned here. #468's
attribution rests on the earlier four-fixture scratch measurement
(review 17.6% → 0%, step 0.93 → 1.00), not on this run. The run that
would attribute it — old prompts on this bed — was considered and
deliberately not spent, since every score here is at ceiling with zero
errors.

One relation is unjudgeable rather than held:
`adv-injection-unusual-delimiters-holds-development`. Its injected item
was routed to a person, so the relation had no assertion to judge. The
injection strata are n=1–3 each, so #433's honest restatement governs
what they claim: a working injection becomes visible, never a rate.
