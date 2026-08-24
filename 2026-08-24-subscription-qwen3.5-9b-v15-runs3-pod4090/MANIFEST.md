# 2026-08-24 — subscription pack, Qwen3.5-9B, scoring v15, `--runs 3`, on a rented RTX 4090

- **Pack**: app.kttl.subscription-audit v1.5.0
- **Model**: qwen3.5-9b-q4_k_m.gguf (9B, Q4_K_M, context 8192)
  — **not** in `app/src-tauri/models.json`, so provenance was recovered
  the way `evals/RENTED-GPU.md` describes: the local copy's digest was
  matched against the Hugging Face tree API until a repository claimed
  both digest and byte count. That repository is
  `bartowski/Qwen_Qwen3.5-9B-GGUF`, file `Qwen_Qwen3.5-9B-Q4_K_M.gguf`.
  Verified on the pod after download: 6,169,341,984 bytes, SHA-256
  `d784ce9eda1a5a7b51e8f705a9e6310844bf4f173654d115823c775fdea56d43`
  — identical to the local weights the earlier 9B audition ran on.
- **Eval set**: development, 84 fixtures, **3 runs**
- **Scoring version**: 15
- **Bed digest**: `blake3:f3512515b617df26e920f749ac342ee10e649fc10593277ff70fbdbd93c68f35`
- **Sidecar**: llama-server 10145 (ad256ded), **CUDA0 (NVIDIA GeForce RTX 4090)**,
  built on the pod from the pinned tag with `KETTLE_CUDA_ARCH=89`
- **Runtime**: context 8192, parallel 1, **reasoning off**, max answer tokens 4096
- **Machine**: **rented** — AMD Ryzen 9 7950X 16-core, 125GB RAM,
  Ubuntu 24.04.3 LTS, RTX 4090, RunPod (pod `2s4vq1jnujnlu5`)
- **Kettle commit**: `7c257c5d3fc6f44b3265ecc7e6e304a3f389e761`, clean tree
- **Recorded**: 2026-08-24, 9m32s per pass (~28.6 min for three)
- **Verdict**: **FAIL**
- **Backs**: no committed baseline. This is a **model audition recording**
  for the lab (M8): the 9B on the subscription pack's full development
  bed. It is archived because the bench's 9B and 27B auditions had never
  been recorded at all, so the best comparison the lab could make rested
  on numbers with nothing behind them.

## Why this run was taken

Two reasons, and the second is the one that needed a rented box.

The subscription pack is the lab's only model-separating bed, and the
9B's earlier showing on it existed only as numbers in a session — no
recording, so nothing re-askable and nothing citable. A run that cannot
be replayed under a later scoring version is a number, not evidence.

`--runs 3` because #533 asks a claim-backing baseline to carry a
stability check and none ever had. Three passes are ~29 minutes here.

## The verdict

```
app.kttl.subscription-audit v1.5.0 · development set · 84 fixtures · 3 runs · RTX 4090

model                   normalise (pooled)              e2e (mean)  review (mean)  time   verdict
qwen3.5-9b-q4_k_m.gguf  0.76 (n=900; 95% CI 0.73–0.79)  1.00        36%            9m32s  FAIL

gate / any-statement / subscription       confident-wrong 0.16 (n=32; CI 0.07–0.32) <= 0.05  UNPROVEN (needs 73)
gate / any-statement / not_subscription   confident-wrong 0.03 (n=60; CI 0.01–0.11) <= 0.05  UNPROVEN (needs 73)
gate / annual-subscription-once-yearly    confident-wrong 0.25 (n=8;  CI 0.07–0.59) <= 0.05  UNPROVEN (needs 73)
gate / free-trial-conversion              confident-wrong 0.12 (n=8;  CI 0.02–0.47) <= 0.05  UNPROVEN (needs 73)
gate / price-rise-mid-series              confident-wrong 0.00 (n=8;  CI 0.00–0.32) <= 0.05  UNPROVEN (needs 73)
claim guardrail / review_routing  0 failed; 303 contained; 0 escaped
confidence  high 78 decisions, error 0.14 · medium 34 decisions, error 0.86 · low 7, all routed
```

The FAIL is the `normalise` threshold (0.85), unchanged in kind from the
4B's 0.69 on this bed: end-to-end is 1.00, so the pipeline's answer is
right while the cosmetic normalisation score is not. **Every ceiling
reads UNPROVEN**, and on these denominators it cannot read anything
else — a 5% bar needs 73 decisions and the per-stratum cells hold 8.

## The three runs agreed on everything

All 84 fixtures reported an identical low and high on every step score,
end-to-end score and review rate, and **a single record digest each** —
the three passes produced byte-identical records.

The result is only worth as much as the check that it was not free. A
results cache serving passes 2 and 3 would report perfect stability
while measuring nothing, which is the failure `--resume`'s refusal
exists to prevent. It was not cached: 9m32s a pass against 28.6 minutes
of wall clock is three full passes of GPU work.

## What is in this entry

`run1/`, `run2/` and `run3/` — all three passes, not just the first.
Other `--runs 3` entries here keep `run1` alone, on the reasoning that
the stability bands live in the baseline JSON. That is true, but the
baseline lives in kettle's tree and this repository is meant to be the
re-askable half; three passes are 39MB and the entry is immutable, so
the cheap moment to keep them is now.

`pod-baseline-subs-9b.json` is the baseline this run wrote. It is **not**
a committed kettle baseline and must not become one: the verdict is FAIL.

## Two things this run found about the playbook

- **`--resume` and `--runs` are mutually exclusive**, correctly and by
  design — a repeat reusing another repeat's answers would report
  perfect stability while measuring nothing. But `evals/RENTED-GPU.md`
  gives `--resume` as the always-on flag in its "Run it detached"
  recipe, and `pod-eval.sh`'s own header calls `--runs` "the one flag a
  rented box is for". Both sentences cannot be followed at once, and
  nothing in the playbook says so. The run refused at exit 2.
- **Ubuntu 24.04 images refuse `pip install`** under PEP 668
  ("externally-managed-environment"), so the playbook's
  `pip install -U "huggingface_hub[hf_transfer]"` line fails on this
  image. A venv is the fix; `--break-system-packages` is not.

## Provenance of the tree on the pod

The pod's checkout came from a `git bundle` of `HEAD` copied over SSH,
not a clone from GitHub. Same committed objects and the same commit id,
and it carries **only committed history** — the working tree's untracked
files could not travel to a rented machine even by accident, which is
the same guarantee `kettle project` inherits from `git ls-files`. No
deploy key was created and the repository's settings were not touched.
