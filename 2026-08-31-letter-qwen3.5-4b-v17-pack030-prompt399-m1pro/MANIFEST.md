# 2026-08-31 — app.kttl.letter-to-actions, 4B, scoring v17, development set (#399 confirmed appointment)

- **Pack**: app.kttl.letter-to-actions 0.3.0
- **Tree**: kettle branch `399-appointment-confirmed` at `a62db28` (over merged #588 `99b5dd1`): the `appointment_confirmed` shape (72 fixtures) and the prompt's confirmed-appointment sentence with example 906
- **Model**: qwen3.5-4b-q4_k_m.gguf (4B, Q4_K_M, context 8192), the file `app/src-tauri/models.json` names
- **Eval set**: development, 479 fixtures
- **Scoring version**: 17
- **Bed digest**: `blake3:1ab11f364af6337101a851121989277ca8592728793698778ad9b78aa66bb6cf`
- **Sidecar**: llama-server 10145 (ad256ded3), Metal, device MTL0 (Apple M1 Pro)
- **Machine**: Apple M1 Pro, 32 GB
- **Runtime**: context 8192, reasoning off
- **Recorded**: 2026-08-31T13:15:27Z
- **Verdict**: PASS — pooled 0.98 (n=545, CI 0.97–0.99); both `any-letter` ceilings 0.00 (obligation 0/240, no-obligation 0/101). `appointment-confirmed` (ungated) 24/24 obligations, 2/72 advice-line inventions.
- **Backs**: `evals/baseline-v17-letter.json` as re-recorded on 31 August, and the `letter-harm-ceilings` claim's `recorded_against.bed` in `assurance/claims.json`.

## Provenance notes

Bed fixtures only, wholly synthetic. `evals/runs/run1` is reused across
sittings and held stale entries from the day's scratch runs; this entry
carries exactly the 479 recordings of the committed bed, selected by
the baseline's own fixture list. The `--baseline` comparison in
`eval.log` is refused (the 72 new fixtures moved the bed digest under
the 30 August baseline); the by-name comparison is in the commit
message of `a62db28`. The first full run of this prompt (11:49–13:55
the same day, wider wording, gate FAIL on one distinct error) is not
archived: it backs no committed number, and the attribution runs on
scratch beds are disposable.
