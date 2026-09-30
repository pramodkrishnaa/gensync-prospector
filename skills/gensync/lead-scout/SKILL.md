---
name: gensync-lead-scout
description: "Scour the free web for B2B startups that fit GenSync's ICP and produce a ranked prospect brief (with a real trigger, a matching case study, a public contact, and talking-point angles) that the human uses to write outreach personally. Never sends or drafts mail."
version: 1.0.0
author: GenSync
license: MIT
platforms: [linux, macos, windows]
metadata:
  hermes:
    tags: [gensync, sales, leads, prospecting, research, gtm, b2b]
    related_skills: [gensync-proposal, gensync-copy, research, web]
---

# GenSync Lead Scout

Find real B2B founders worth reaching out to, and hand the user a ranked brief
they can act on in minutes. **This skill researches — it does not write or send
email.** The human writes every message personally (see `../CONTEXT.md`).

## Before you start
1. Read `../CONTEXT.md` (the ICP, proof, and case studies you rank against).
2. Get the niche from the user, or default to a broad sweep. Examples:
   "YC S26 B2B infra", "recently funded Indian SaaS", "devtools launching this month".

## Pipeline

### 1. Source (free only — no paid APIs, no LinkedIn scraping)
Use `web_extract(urls=[...])` and web search over public pages:

| Source | How |
|--------|-----|
| Y Combinator directory | `web_extract(urls=["https://www.ycombinator.com/companies?batch=<batch>&industry=B2B"])` |
| Product Hunt (recent launches) | `web_extract(urls=["https://www.producthunt.com/"])` then follow product pages |
| Funding news | search "seed round B2B <sector> <month> 2026 announced" → `web_extract` the article |
| Accelerator cohorts | EF / Google for Startups / IIT-IIM demo-day pages via search + `web_extract` |
| Founder posts | search X/LinkedIn public posts: "launching", "just raised", "hiring head of marketing" |

Only use `browser` / `computer_use` for a page that blocks `web_extract`. Don't
build scrapers — a few good sources beat a broad flaky crawl.

### 2. Qualify (gpt-oss-120b)
For each candidate, score fit **0..1** against the `CONTEXT.md` ICP. Drop anything
that is pure-consumer, has no visible founder, or has no trigger AND no contact.
Find the concrete **trigger** and its date (raise / launch / batch / GTM hire /
big release). Match the **closest case study** as proof.

### 3. Build the lead objects
Emit a JSON array; one object per surviving lead, exactly these fields:

```json
[{
  "company": "Acme", "domain": "acme.com",
  "what": "one line on what they sell and to whom",
  "person": "Founder name", "contact": "public email or @handle or '' if none public",
  "trigger": "raised $2M seed", "trigger_date": "2026-09-20",
  "fit": 0.85, "case_study": "ConnectME",
  "angle": ["their landing buries the product in jargon", "seed = launch window now", "we did ConnectME's rebrand+site in one pass"],
  "source_url": "https://..."
}]
```
Rules: `contact` is **only** a genuinely public address/handle — never a guessed
pattern. `angle` = 2-3 talking points the user turns into their own email, NOT a
written email.

### 4. Rank + output
For a handful of leads, just rank them yourself (fit x how fresh the trigger is)
and output the Markdown brief directly — no script needed.

For a larger batch or when the user wants the CSV, use the **`terminal`** tool
(that is the real shell tool name — do NOT invent a `process`/`run` tool):

```
terminal(command="python scripts/rank.py leads.json --csv gensync-prospects.csv")
```
(Write `leads.json` first with the `write_file`/`terminal` tool.) It dedups by
domain, ranks by `fit x trigger-recency`, prints the Markdown brief, and writes
the CSV. Give the user the Markdown brief either way.

### 5. Track (optional)
Add the top prospects to a kanban board so outreach is trackable:
```
kanban_create(title="<company> — <trigger>", assignee="me")
```
Board flow the user works: New → Contacted → Replied → Call booked.

## Guardrails
- Never fabricate a trigger, a contact, or a metric. If unknown, say so / leave blank.
- Every lead cites a `source_url` the user can verify in one click.
- Quality over volume: 5 sharp, real, well-triggered leads beat 50 guesses.

## Self-check
`python scripts/rank.py --selftest` (verifies dedup + ranking, offline).
