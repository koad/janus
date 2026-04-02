---
title: "2026-04-02 Watch Protocol"
created: 2026-04-02
updated: 2026-04-02
tags: [protocol, monitoring, watch-brief]
status: active
priority: critical
---

# Janus Watch Protocol

**Entity:** Janus  
**Date:** 2026-04-02  
**Purpose:** Define monitoring scope, alert triggers, and response actions for stream watching

---

## Monitored Repositories

Atom feeds monitored for all koad:io entity repos:

| Entity | Repo | Specialty |
|--------|------|-----------|
| Juno | koad/juno | Orchestration |
| Vulcan | koad/vulcan | Build products |
| Vesta | koad/vesta | Platform/protocol |
| Mercury | koad/mercury | Communications |
| Muse | koad/muse | UI beauty |
| Sibyl | koad/sibyl | Research |
| Argus | koad/argus | Diagnostician |
| Salus | koad/salus | Entity healer |
| Janus | koad/janus | Stream watcher |
| Aegis | koad/aegis | Confidant |
| Veritas | koad/veritas | Quality guardian |

---

## Event Types Monitored

### 1. Commit Events
- Author (expected vs unexpected)
- Message format (conventional commit compliance)
- Timing patterns (bursts, silence)
- File scope (trust-sensitive locations)

### 2. Issue Events
- New issues filed
- Issue aging (unassigned stale issues)
- Cross-entity issue conflicts
- Missing metadata (no labels, no milestone)

### 3. Pull Request Events
- PR age (unreviewed duration)
- Reviewer coverage
- Merge conflicts
- Unauthorized target branches

### 4. Trust Bond Events
- New peer bonds
- Bond revocations
- Scope changes

---

## Alert Triggers

### Tier 1: Immediate Alert

| Trigger | Pattern | Action |
|---------|---------|--------|
| Unknown actor commits | Non-entity author detected | File issue on repo, tag koad |
| Unauthorized branch push | Direct push to main/master | File issue, tag Juno, tag koad |
| Trust bond revoked | Bond removal event | File issue, tag Juno immediately |
| Malformed commit burst | 3+ commits with bad messages | File issue on repo |
| Crossed wires | Issue references wrong entity | File issue, tag both entities |

### Tier 2: Escalation Alert

| Trigger | Pattern | Action |
|---------|---------|--------|
| Unexpected author | Non-entity author on sensitive file | File issue on repo, tag Juno |
| Stale issue | Unassigned > 48h | File issue, tag entity owner |
| Unreviewed PR | No review > 24h | File issue on repo |
| Silent repo | No activity > 7 days | Log internally; if > 14 days, alert |
| Broken conventions | Pattern of 3+ malformed commits | File issue, tag entity |
| Conflicting PR | Merge conflict unresolved > 24h | File issue on repo |

### Tier 3: Observation (Log Only)

| Trigger | Pattern | Action |
|---------|---------|--------|
| Single odd commit | One off-form message | Log to alerts/ directory |
| Minor metadata gap | Missing label or milestone | Log internally |
| Expected inactivity | Planned silence period | Log with context |

---

## Response Actions

### File GitHub Issue

Standard alert format:

```markdown
## [Janus Alert] <Event Type>

**Trigger:** <what was detected>
**Repo:** koad/<entity>
**Time:** <timestamp>
**Pattern:** <description>

**Context:**
<why this matters>

**Recommended Action:**
<what should happen next>

---
*Filed by Janus — stream watcher for koad:io*
```

### Tagging Protocol

| Severity | Tag | When |
|----------|-----|------|
| Root-level | @koad | Unauthorized access, trust violation |
| Escalation | @koad/juno | Needs routing, coordination |
| Standard | None | Entity can self-resolve |

---

## Alert Calibration Rules

1. **Pattern > Event:** A single anomaly is logged; a pattern (3+) triggers alert
2. **Context matters:** Known transitions (new entity gestation) suppress false positives
3. **Escalate uncertainty:** When in doubt, log internally first
4. **False positives erode trust:** Better to under-alert than over-alert

---

## Monitoring Workflow

```
Poll atom feeds (all entity repos)
        ↓
Parse events → Categorize
        ↓
Check against Tier 1/2/3 rules
        ↓
Match found?
  → Yes: Execute action (file issue / log)
  → No:  Continue
        ↓
Log session summary to alerts/
        ↓
Commit + push if state changed
```

---

## Implementation Notes

- **GitClaw** on fourty4 wakes Janus on events
- **OpenClaw** (llama3.2:latest) provides analysis layer
- Polling interval: Configurable, default 15 minutes
- Alert output: GitHub Issues on affected entity repos
- Internal logs: `~/.janus/alerts/` directory

---

*Janus watches. Janus alerts. Janus does not fix.*
