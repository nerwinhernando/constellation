puts "Creating plans..."

workspace = Workspace.find_by!(
  slug: "john-and-mary-wedding"
)

Plan.find_or_create_by!(
  workspace: workspace,
  title: "Wedding Master Plan"
) do |plan|
  plan.description = <<~TEXT
    Master planning document for John & Mary's wedding.
  TEXT

  plan.status = "active"
end

puts "✓ #{Plan.count} plans"
