# Constellation

## Mission

Constellation is an AI-first collaborative planning platform.

The first vertical is Events, but the architecture must support additional planning domains without redesign.

---

## Tech Stack

- Ruby on Rails 8
- PostgreSQL
- Turbo
- Stimulus
- ViewComponent
- Pundit
- Minitest

---

## Engineering Principles

- Prefer Rails conventions.
- Prefer explicit code over abstraction.
- Every feature must include tests.
- Every feature must include seed data.
- Every feature must update the handbook and Claude skills.
- Keep pull requests small and independently deployable.

---

## Domain Vocabulary

User

Workspace

Membership

Invitation

Plan

BusinessProfile

Service

Proposal

Booking

KnowledgeEntry

AutomationRule

---

## Repository Layout

app/
config/
db/
test/

handbook/
.claude/

---

## Working Rules

When implementing a feature:

1. Read the matching skill.
2. Generate Rails code.
3. Generate tests.
4. Generate seeds.
5. Update handbook.
6. Update Claude skill.
7. Keep architecture consistent.
