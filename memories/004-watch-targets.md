---
title: "004 - Watch Targets"
created: 2026-04-02
tags: [watch, targets, monitoring]
status: active
priority: high
---

# Janus — Watch Targets

What Janus monitors. Check these on each session. Flag broken patterns to Juno via GitHub Issue (label: `pattern-alert`).

---

## Entity repos — activity feed

Monitor commit activity. Flag: entity that hasn't committed in >7 days (possible stall), entity that is committing at unusual hours without explanation, commits that contradict declared role.

| Entity | Repo | Home machine |
|--------|------|-------------|
| Juno | github.com/koad/juno | thinker |
| Vulcan | github.com/koad/vulcan | wonderland |
| Vesta | github.com/koad/vesta | wonderland |
| Aegis | github.com/koad/aegis | thinker |
| Mercury | github.com/koad/mercury | fourty4 |
| Veritas | github.com/koad/veritas | thinker |
| Muse | github.com/koad/muse | thinker |
| Sibyl | github.com/koad/sibyl | fourty4 |
| Argus | github.com/koad/argus | thinker |
| Salus | github.com/koad/salus | thinker |
| Janus | github.com/koad/janus | thinker |

Atom feeds: `https://github.com/koad/<entity>/commits/master.atom`

---

## Framework repo

| Repo | Watch for |
|------|-----------|
| github.com/koad/koad-io | Breaking changes to command structure, gestate process, hooks |

Flag any commit to koad-io that could break entity invocation or the `executed-without-arguments` hook pattern.

---

## Operations board

- GitHub Project: https://github.com/users/koad/projects/4
- Watch for: issues assigned but not updated in >3 days, issues closed without a comment, new issues assigned to entities that don't match their declared role

---

## Issue queues

Monitor open issues on entity repos. Flag:
- Issue open >5 days with no activity
- Issue assigned to wrong entity (misrouted work)
- Issue that references a dependency that was closed/changed

| Repo | Issue queue |
|------|------------|
| koad/juno | github.com/koad/juno/issues |
| koad/vulcan | github.com/koad/vulcan/issues |
| koad/mercury | github.com/koad/mercury/issues |
| koad/argus | github.com/koad/argus/issues |

---

## Pattern library — what to flag

| Pattern | Signal | Action |
|---------|--------|--------|
| Stalled entity | No commits in >7 days | File issue on koad/juno |
| Role drift | Entity committing outside declared scope | File issue on koad/juno |
| Silent blocker | Issue open >5 days, no comment | File issue on koad/juno |
| Pipeline break | Mercury post not gated by Argus | File issue on koad/juno |
| Trust chain gap | New entity without bond | File issue on koad/juno |
| Unclosed loop | Issue closed without deliverable link | Note in watch report |

---

## Watch report output

Save to `~/.janus/reports/YYYY-MM-DD-watch.md`. Include:
- Repos checked
- Commits since last watch
- Patterns flagged (with links)
- Issues filed
- Overall status: CLEAN / ALERTS

Commit and push after each watch session.

---

## Cadence

- **Active periods:** check daily
- **Quiet periods:** check every 3 days
- **After a major operation:** check immediately (e.g. after a mass entity update like 2026-04-02)
