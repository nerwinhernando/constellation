# Workspace

## Purpose

Workspace is the collaboration boundary.

Every important business record belongs to exactly one Workspace.

Examples:

- Plans
- Decisions
- Knowledge
- Marketplace
- Automations

---

## Associations

Workspace

has_many Memberships

has_many Users through Memberships

has_many Invitations

belongs_to Owner

---

## Rules

Workspace always has exactly one owner.

Users may belong to multiple workspaces.

Owner is automatically added as the first Membership.

Workspace uses UUID primary keys.

Workspace URLs should eventually use slugs.

Never authorize directly using User.

Authorization should happen through Membership.

---

## Future Capabilities

Planning

Marketplace

Knowledge

Automation

Notifications
