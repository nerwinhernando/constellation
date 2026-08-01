# frozen_string_literal: true

puts "Creating invitations..."

workspace = Workspace.first
owner = workspace.owner

Invitation.find_or_create_by!(
  workspace: workspace,
  email: "future.member@example.com"
) do |invitation|
  invitation.invited_by = owner
  invitation.role = "member"
  invitation.token = SecureRandom.urlsafe_base64(32)
  invitation.expires_at = 7.days.from_now
end

puts "✓ #{Invitation.count} invitations"
