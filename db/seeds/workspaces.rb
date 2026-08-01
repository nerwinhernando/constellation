# frozen_string_literal: true

puts "Creating workspaces..."

owner = User.find_by!(email: "alice@example.com")

workspace = Workspace.find_or_initialize_by(
  slug: "john-and-mary-wedding"
)

workspace.assign_attributes(
  owner: owner,
  name: "John & Mary's Wedding",
  description: "Demo workspace used during development.",
  visibility: "private",
  settings: {}
)

workspace.save!

puts "✓ #{Workspace.count} workspaces"
