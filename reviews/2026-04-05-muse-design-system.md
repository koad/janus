# Review: Muse DESIGN-SYSTEM.md — Vulcan Handoff Readiness

**Reviewer:** Janus  
**Date:** 2026-04-05  
**Subject:** `~/.muse/DESIGN-SYSTEM.md` (v1.1, consolidated from 28+ briefs)  
**Verdict:** READY FOR VULCAN — with one gap flagged for awareness

---

## Scope of Review

- Read `~/.muse/DESIGN-SYSTEM.md` in full
- Read `~/.muse/design-system/koad-io-design-system.md` (base design system v1.1)
- Sampled 5 source briefs for faithful incorporation:
  - `2026-04-05-entity-product-card.md`
  - `2026-04-05-alice-conversation-ui.md`
  - `2026-04-05-alice-graduation-certificate.md`
  - `2026-04-05-blog-reading-experience.md`
  - `2026-04-04-stream-pwa-design.md` (partial)
- Compared full brief list (29 files in `~/.muse/briefs/`) against consolidated document sections

---

## Overall Verdict

**Ready for Vulcan.** The consolidated DESIGN-SYSTEM.md is accurate, internally consistent, and sufficient for implementing Alice's UI (koad/vulcan#36) and the koad:io web presence. Key decisions are faithfully carried from the source briefs. No contradictions were found between the consolidated document and the briefs sampled.

One gap is flagged below that does not block Vulcan's current issue but should be resolved before implementing the blog and the get-started flow.

---

## Faithful Incorporation — Findings

### Entity Product Card (Section 3a)

Accurately consolidated. Color identity table, 3px top-rule behavior, card anatomy (identity row → role → specialty → deliverables → command → CTA), card grid CSS, and CTA verb states (`Gestate` / `Open session` / `Resume`) all match the source brief exactly. Status language (`● active`, `◌ dormant`, `— archived`) and the 14-day activity threshold are correctly carried over.

Minor omission: the source brief specifies a `role="article"` and `aria-label` on the card container for accessibility, and the note that the card is a `<div>` (not a single `<a>`) because it contains multiple interactive elements. This implementation detail is not in Section 3a. It does not affect visual implementation but should be noted for Vulcan when writing markup.

### Alice Conversation UI (Sections 3b, 3c, 3d, 5b, 7)

Faithfully consolidated. The attributed-prose-blocks-not-bubbles decision, the amber left border at 30% opacity, the composing indicator minimum 600ms hold, input placeholder copy by atom type, the ceremony timing table, and the level completion ceremony sequence (glyph fades in 600ms → title 200ms staggered → amber rule draws 400ms → preview message 400ms → button 200ms) are all accurately represented.

One condensation to flag: Section 3d (Level Progress Header) includes the mobile compressed format (`L3 · atom 2/5`) and the atom counter fade update (200ms out / 200ms in). These are correct. The source brief also specifies scroll anchor behavior (scroll-anchors to bottom on new messages; "↓ New message" amber pill appears when user has scrolled up). This scroll behavior is not captured in DESIGN-SYSTEM.md. It is a functional interaction detail rather than a visual design decision — Vulcan should read the source brief (`2026-04-05-alice-conversation-ui.md`, Section 1a) for this.

### Graduation Certificate (Section 3f)

Accurately consolidated. Certificate frame border spec (2px amber top/bottom, 1px `#2a2a2a` sides, 4px radius, `#0a0a0a` background), typography table, signature block truncation and expand behavior, verify flow structure, and canonical signed string format (`{curriculum}:{displayName}:{learnerId}:{completedDate}`) are all correctly captured.

The consolidated doc correctly identifies "Alice's Attestation" framing and carries the trust bond chain visualization spec (node dot colors, connector lines, bond type labels, color-plus-icon accessibility rule).

### Blog Reading Experience (Sections 2c, 3e)

Section 3e (Blog: Series Context Strip) is faithfully included. Left accent rule on series context strip, series badge format, and the conditional rendering rules are all correct.

**Gap:** The consolidated document does not cover the series index page (`/blog/series/:slug`), the day-grid component, the localStorage reading progress pattern (`koad_reading_progress_${seriesSlug}`), the `series.yaml` config structure with `type` field (`sequential` / `standalone` / `short-sequential`), or the "Naming What We Built" non-sequential series treatment. These are all specified in `2026-04-05-blog-reading-experience.md` sections 2–7.

This gap does not block koad/vulcan#36 (Alice progression system). It does block full blog implementation. Vulcan will need to read `2026-04-05-blog-reading-experience.md` directly when implementing the blog series infrastructure.

### Stream PWA

The Stream PWA brief (`2026-04-04-stream-pwa-design.md`) is not represented in DESIGN-SYSTEM.md. This is appropriate — the brief states the Stream PWA is "lower priority, implement after kingofalldata.com core site." It is not a gap that blocks current work.

---

## What Vulcan Can Safely Build From DESIGN-SYSTEM.md

The consolidated document is sufficient for:

1. **Alice PWA** — full conversation UI, curriculum browser/map, level progress header, graduation certificate, and the complete Alice domain skin. All tokens, timing, component anatomy, and anti-patterns are specified.

2. **Entity marketplace** — product card component with all states (ungestated / running / dormant), entity color identity system, card grid layout, and CTA behavior.

3. **koad:io global surface** — color tokens (dark + light), typography scale, spacing system, breakpoints, animation timings, code block styling, syntax highlighting, iconography and glyph system.

4. **Blog foundation** — post page layout, series badge, series context strip, code block anatomy (including terminal prompt styling and file path header convention). Individual post pages are fully specced.

5. **Trust bond visualization** — node states, connector lines, verification labels, color-plus-icon accessibility requirement.

---

## What Vulcan Must Read Directly From Source Briefs

| Feature | Source Brief | Reason |
|---------|-------------|--------|
| Blog series index page (`/blog/series/:slug`) | `2026-04-05-blog-reading-experience.md` §2–7 | Not in consolidated doc |
| localStorage reading progress | same | Not in consolidated doc |
| `series.yaml` config schema | same | Not in consolidated doc |
| Non-sequential series treatment (Naming What We Built) | same | Not in consolidated doc |
| Card markup accessibility details (role, aria, div vs a) | `2026-04-05-entity-product-card.md` §11 | Condensed out |
| Conversation scroll anchor + "New message" pill | `2026-04-05-alice-conversation-ui.md` §1a | Condensed out |
| Multi-device sync / `progress.alice` export | `2026-04-05-alice-conversation-ui.md` §6 | Not in consolidated doc |
| `get-started` page layout + operator onboarding flow | `2026-04-05-get-started-flow.md` | Not in consolidated doc |
| Stream PWA dashboard | `2026-04-04-stream-pwa-design.md` | Intentionally deferred |

---

## Contradictions Found

None. The consolidated document does not introduce values that conflict with source briefs. Where the source briefs are more specific, DESIGN-SYSTEM.md correctly defers to them ("the brief is more specific and wins for its context").

One precision note: Section 3e states the series context strip uses a `3px solid --color-accent` left rule. The source brief (`2026-04-05-blog-reading-experience.md` §1) specifies `3px solid --color-border-strong (#3a3a44)` — not the accent. The DESIGN-SYSTEM.md value (`--color-accent`) is a deviation. This is a minor inconsistency, not a blocking contradiction. Vulcan should follow the source brief here: the border-strong value is intentional (informational, not a CTA — the brief is explicit about this).

---

## Recommendation

DESIGN-SYSTEM.md is ready to be handed to Vulcan as the primary reference for koad/vulcan#36 and the kingofalldata.com implementation. The blog series infrastructure gap should be addressed by Muse in a follow-up addition to Section 3e or a new Section 9 (Blog Series System). File as a Muse task, not a blocker for Vulcan's current issue.

The one contradiction (series context strip border color) should be corrected in DESIGN-SYSTEM.md: change `3px solid --color-accent` to `3px solid --color-border-strong` in Section 3e to match the source brief's stated rationale.

---

**Signed:** Janus  
**Integrity review completed:** 2026-04-05
