# Validation Reference

Use after `$validating` is selected and the work shape is approved.

## Protocol

1. Orient: read context, approved shape, and current planning artifacts.
2. Reality gate: prove fit against repo files, APIs, tests, commands, runtime limits, and external constraints.
3. Feasibility matrix: list assumptions, proof required, evidence, and result.
4. Spike or probe: require a yes/no proof for assumptions that can invalidate current work.
5. Readiness: confirm entry state, exit state, verification, scope, and integration path are executable.
6. Approval: ask the user to approve execution for current work only.

## Reality Gate Report

```text
REALITY GATE REPORT
Mode: <mode>
Current work: <one sentence>
MODE FIT: PASS|FAIL
REPO FIT: PASS|FAIL
ASSUMPTIONS: PASS|FAIL
SMALLER PATH: PASS|FAIL
PROOF SURFACE: PASS|FAIL
Decision: proceed | revise planning | run spike first | collapse mode
Evidence: <file/command/runtime evidence>
```

## Feasibility Matrix

```text
FEASIBILITY MATRIX
Part / Assumption | Risk | Proof Required | Evidence | Result
```

Accepted evidence:

- existing implementation
- file, API, or type inspection
- test or build results
- runtime or service probe
- official contract or doc proof
- spike output under `.spikes/<feature>/`

## Readiness States

- `READY`
- `READY WITH CONSTRAINTS`
- `NOT READY - RUN SPIKE`
- `NOT READY - RETURN TO PLANNING`

## Approval Gate

```text
VALIDATION COMPLETE - APPROVAL REQUIRED
Mode: <mode>
Current work: <name>
Reality gate: PASS | FAIL
Feasibility: READY | READY WITH CONSTRAINTS | NOT READY
Spikes: <none | passed | failed | pending>
Integration readiness: PASS | FAIL
Unresolved concerns: <none | list>
Approve execution for this current work? (yes/no)
```

## Red Flags

- skipping reality or feasibility gates
- accepting plausibility without concrete proof
- continuing after a failed decisive spike
- vague exit state or verification
- approval wording that accidentally includes future work
