# 2026-08-11 — letter pack, Qwen3.5-4B, scoring v13, on a rented GPU

- **Pack**: app.kttl.letter-to-actions 0.2.0
- **Model**: qwen3.5-4b-q4_k_m.gguf (4B, Q4_K_M, context 8192)
  — sha256 `13c16f426047e2de38cd075bdade4a7bcbc8c774384876f677740cda65f8a983`,
  verified on the pod against the entry added to `models.json` the same
  day.
- **Eval set**: development, 397 fixtures
- **Scoring version**: 13
- **Bed digest**: blake3:6438b2bb812dfce7b2a…
- **Sidecar**: llama-server 10145 (ad256ded), built from source on the
  pod with CUDA and `CMAKE_CUDA_ARCHITECTURES=120`
- **Runtime policy**: context 8192, parallel 1, reasoning off, max
  answer tokens 4096 (#232)
- **Machine**: **rented** — RunPod, NVIDIA RTX 5090 (Blackwell, 32GB),
  Intel Xeon Gold 6530, 755GB RAM, Ubuntu 24.04.3
- **Tree**: clean at `9709cad`, no hand-applied patches
- **Recorded**: 2026-08-11, stamped 16:50:32Z at run start
- **Backs**: `evals/baseline-v13-letter.json` in kettle — verdict PASS.
  Obligation precision and recall 1.00 (n=493), confident-wrong 0.00
  with Wilson upper 0.0160 against the 0.02 ceiling; no_obligation 1.00
  and 1.00 (n=894), Wilson upper 0.0374 against 0.05. 3872 claim
  candidates, 38 routed to review, **0 escaped and no guardrail
  failure of any kind**. 12 relations held, none unjudgeable.

## This is a pod run, and the first one

Run on hardware nobody here owns, which is allowed because every fixture
in this bed is synthetic by construction. Nothing derived from a real
document has ever been on that machine. `evals/RENTED-GPU.md` is the
playbook this run wrote.

**The timings are the pod's, not a tier claim.** A tier sentence is a
claim about somebody's own laptop and must never be merged from here.

**Scores across machines are still asserted rather than measured.** This
recording was made on CUDA where every other letter recording was made
on Metal. It cost nothing this time — the bed changed, so #320 refused
any comparison regardless, and no `--baseline` was passed. Anyone
comparing this to a Mac-made recording later is comparing two
instruments, and the experiment that would settle it (same commit, same
bed, same weights, both machines) has not been run.

## What it measures — and the third run is the one that counts

Three runs happened on 11 August; this is the third and the only one
whose numbers stand.

1. **15:57Z** — first attempt. Verdict FAIL, on one confident-wrong
   obligation in the new passive stratum.
2. **~16:20Z** — the same run resumed after a dropped connection killed
   it at 326 of 397. `--resume` reused the scored fixtures correctly.
3. **16:50Z** — this one, after the bed was fixed.

The FAIL was **the bed's fault, not the model's**, and both defects were
in #456's own passive family:

- The generator dropped a sender's `£0.00` into a payment construction
  and produced *"Settlement of £0.00 must be received within 35 days"*.
  The model read it as a `response`; the bed insisted `payment`. On that
  sentence the model's answer is at least as defensible, and that single
  disagreement failed a gate with zero headroom.
- 24 of 30 expectations wanted the anchor *"the date of this letter"*
  from passages that never said it.

Both fixed in `9709cad`, with
`every_passive_expectation_is_answerable_from_its_own_passage` holding
them. This is the #457 pattern for the second time — a genuine ambiguity
authored into a bed and then scored as a model error — and worth
remembering that the commit which introduced it *quoted #457 while doing
it*.

`pod-eval.log` here is cumulative across all three runs (`tee -a`), so
the FAIL table inside it is run one's. The baseline is the record of
run three.

## What the passive family established

30 of 30 passive obligations read correctly, precision 1.00, and the 30
counter-cases per set clean — no drift toward "every passive sentence is
an obligation". Every ceiling this pack had ever cleared before today
was cleared on imperatives alone; it now stands on both constructions.

It also means #458's *"ask who is being told to act"* did not cost
recall on sentences naming no actor, which was the specific risk with no
headroom and the reason #456 existed.
