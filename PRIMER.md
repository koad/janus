# PRIMER: Janus

Janus watches the GitHub atom feeds, daemon emission stream, and DDP indexed.* publications for all ~20 entity repos and reports anomalies — stalled entities, role drift, silent blockers, pipeline breaks, trust chain gaps. He alerts and files briefs; he does not fix. Named for the two-faced Roman god who looks both backward and forward simultaneously. Natural home is fourty4 (GitClaw always-on watching).

---

## Current State

**Gestated. Watch infrastructure live. Two signal channels operational.**

### What Janus Watches

| Feed | Signals |
|------|---------|
| GitHub atom feeds | Unexpected authors, broken conventions, stall patterns |
| Daemon MCP emission stream | Emission gaps, flight cadence, entity-level silence |
| DDP indexed.* publications | AnnouncementSurface, Tips, business-layer divergence |
| Dance-hall vs daemon cadence | > 20% divergence over 24h is a signal |
| Trust bond activity | New bonds, revocations, scope changes |
| Pipeline | Mercury publishing stalls, Veritas review backlog |
| Role drift | Entities working outside their scope |

### What's Complete
- GitHub atom feed watchers: 21 entity repos tracked (`watchers/`) — Rufus added 2026-05-01
- `github-feeds.sh` watch script live
- Emission triggers live (`triggers/`) — daily stream logs in `streams/`
- Watch sessions through 2026-04-18 (sweeps in `sweeps/`)
- Alert triage current as of 2026-04-25
- Escalation protocol: Janus → briefs/alerts/ → Juno (brief/MCP) → koad (direct, root-level only)
- **Structural completeness scan** live (`scans/structural-completeness.sh`) — weekly cadence
- **PR staleness scan** live (`scans/pr-staleness.sh`) — weekly cadence

### Open Alerts

| Alert | Entity | Signal | Status |
|-------|--------|--------|--------|
| 2026-04-17 | Sibyl | Sigchain genesis authored by Juno (not Sibyl) | open — 14 days |
| 2026-04-25 | Cacula | Thin memories (1 file); GitHub-primary origin | open — 5 days |
| 2026-04-25 | Copia | Missing README.md | open — 5 days |
| 2026-04-25 | Lyra | Missing README.md; 1 memory file | open — 5 days |
| 2026-04-25 | Juno | Missing PRIMER.md and README.md | resolved — 2026-05-01 |
| 2026-05-01 | Mercury | Post 00023 Iris voice review gate overdue | open — 00023 target publish 2026-05-05 |
| 2026-05-01 | kingdom | W-003 dance-hall chain stub — production gate untracked | open |

### Escalation Chain

```
Janus detects anomaly
    → Files brief in ~/.janus/briefs/
    → Files alert in ~/.janus/alerts/
    → Escalates to Juno via brief or MCP if multi-entity or systemic
    → Tags koad directly only for root-level concerns
```

---

## Active Work

Standing feed monitoring + emission stream watching. Two new mechanical scans added 2026-04-25 (structural completeness + PR staleness). Coverage gap brief resolved.

---

## Blocked

- **fourty4 API auth** — koad/juno#44 blocks autonomous wake-on-event triggers
- **GitClaw configuration** — full always-on monitoring requires GitClaw event routing to be confirmed

---

## Key Files

| File | Purpose |
|------|---------|
| `ENTITY.md` | Full identity, escalation protocol, behavioral constraints |
| `GOVERNANCE.md` | Trust chain and authorization |
| `watchers/` | Atom feed scripts |
| `triggers/` | Daemon emission trigger scripts |
| `streams/` | Daily daemon emission logs (warning + error type) |
| `sweeps/` | Completed sweep session logs |
| `alerts/` | Filed anomaly records |
| `briefs/` | Internal intake + Juno communications |
| `scans/` | Structural completeness + PR staleness scan scripts and reports |
