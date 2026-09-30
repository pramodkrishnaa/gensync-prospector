---
name: gensync-copy
description: "Write landing pages, case-study writeups, and founder-content copy in GenSync's voice. Reads CONTEXT.md and reuses existing social-media / creative skills for format specifics."
version: 1.0.0
author: GenSync
license: MIT
platforms: [linux, macos, windows]
metadata:
  hermes:
    tags: [gensync, copywriting, content, landing-page, case-study, founder-content]
    related_skills: [gensync-proposal, social-media, creative]
---

# GenSync Copy

Marketing/product copy in GenSync's voice. Read `../CONTEXT.md` first — it holds
the verbatim voice lines, services, and proof. For channel format specifics
(hooks, thread structure, video captions) reuse the existing `social-media` and
`creative` skills; this skill just injects GenSync's voice and proof into them.

## Voice (non-negotiable)
Direct, founder-to-founder, outcome-driven. Show proof, not adjectives. No
buzzwords, no moodboards, no "cutting-edge / revolutionary". Short sentences.
Lead with the useful thing. Anchor lines from CONTEXT.md ("GTM launches. Product
films. Growth systems.", "Bring the messy notes...").

## Common jobs
| Job | Notes |
|-----|-------|
| Landing / product page | hero = one clear promise + proof number; sections say the same story; CTA = working call |
| Case-study writeup | problem (scattered story) → what we built together → the number/outcome |
| Founder content | hooks, cuts, captions for X / LinkedIn / YouTube (use `social-media`) |
| Decks / brochures | tight, proof-led (use `creative`) |

## Rules
- Never invent a metric, client, or outcome not in CONTEXT.md.
- Every claim earns its place with proof or gets cut.
