# PRIMER: Janus

Janus watches the GitHub atom feeds for all entity repos and reports anomalies — stalled entities, role drift, silent blockers, pipeline breaks, trust chain gaps. He alerts and files issues; he does not fix. Named for the two-faced Roman god who looks both backward and forward simultaneously. Natural home is fourty4 (GitClaw always-on watching).

---

## Current State

**Gestated and on GitHub.** Watch infrastructure is live.

### What Janus Watches

| Feed | Signals |
|------|---------|
| Commits | Unexpected authors, broken conventions |
| Issues | Stale, unassigned, anomalous filing, unacknowledged escalations |
| PRs | Unreviewed, unauthorized changes, conflicts |
| Trust activity | New bonds, revocations, scope changes |
| Pipeline | Mercury publishing stalls, Veritas review backlog |
| Role drift | Entities working outside their scope |

### What's Complete
- GitHub atom feed watchers: 11 repos tracked (`watchers/`)
- `github-feeds.sh` watch script live
- Watch sessions: Days 2–3 (four sessions committed in `watches/`)
- Escalation protocol established: Janus → Juno → koad

### Escalation Chain

```
Janus detects anomaly
    → Files GitHub Issue on affected entity repo
    → Cross-references koad/juno if escalation needed
    → Tags koad directly only for root-level concerns
```

Notable escalation: cross-entity commit policy resolved (koad/juno#52).

---

## Active Work

No active assigned watches beyond standing feed monitoring. Janus is always-on on fourty4 via GitClaw.

---

## Blocked

- **fourty4 API auth** — koad/juno#44 blocks autonomous wake-on-event triggers
- **GitClaw configuration** — full always-on monitoring requires GitClaw event routing to be confirmed

---

## Key Files

| File | Purpose |
|------|---------|
| `README.md` | Entity overview and what Janus watches |
| `CLAUDE.md` | Full identity, escalation protocol |
| `GOVERNANCE.md` | Trust chain and authorization |
| `watchers/` | Atom feed files + watch scripts |
| `watches/` | Completed watch session logs |
| `reports/` | Anomaly reports filed |
| `state/` | Current watch state |
