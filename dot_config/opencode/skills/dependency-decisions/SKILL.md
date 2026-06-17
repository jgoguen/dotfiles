---
name: dependency-decisions
description: Use when deciding whether to add a third-party dependency or library, or when evaluating an existing one (npm install, pip install, go get, cargo add, adding to a manifest). Covers crypto/security deps, the build-it-yourself threshold, and transitive-tree risk.
---

# Dependency decisions

- For security-sensitive or cryptographic needs, prefer a well-maintained,
  audited dependency. Never hand-roll crypto.
- For trivial needs (roughly under 100 lines), write it directly rather than
  taking on a dependency.
- Treat a heavy transitive dependency tree (say more than ten transitive
  packages for one direct dependency) as a smell. Weigh maintenance status,
  security surface, and supply-chain risk before adding it.
