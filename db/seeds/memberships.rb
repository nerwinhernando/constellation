# frozen_string_literal: true

puts "Creating memberships..."

workspace = Workspace.find_by!(slug: "john-and-mary-wedding")

[
  ["bob@example.com", "admin"],
  ["charlie@example.com", "member"],
  ["diana@example.com", "guest"]
].each do |email, role|
  user = User.find_by!(email_address: email)

  membership = Membership.find_or_initialize_by(
    workspace: workspace,
    user: user
  )

  membership.role = role
  membership.joined_at ||= Time.current

  membership.save!
end

puts "✓ #{Membership.count} memberships"
