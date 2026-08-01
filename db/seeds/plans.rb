# frozen_string_literal: true

puts "🌱 Seeding plans..."

workspace = Workspace.find_by!(
  slug: "john-and-mary-wedding"
)

owner = User.find_by!(
  email: "alice@example.com"
)

plan = workspace.plans.find_or_create_by!(
  title: "Wedding Master Plan"
) do |p|
  p.description = "Master planning document for the wedding."
  p.status = :active
end

puts "  ✓ #{plan.title}"

planning = plan.phases.find_or_create_by!(
  title: "Planning"
) do |phase|
  phase.position = 1
end

ceremony = plan.phases.find_or_create_by!(
  title: "Ceremony"
) do |phase|
  phase.position = 2
end

reception = plan.phases.find_or_create_by!(
  title: "Reception"
) do |phase|
  phase.position = 3
end

def seed_task(phase, title, **attributes)
  phase.tasks.find_or_create_by!(title: title) do |task|
    task.position = attributes.fetch(:position, 0)
    task.priority = attributes.fetch(:priority, :normal)
    task.status = attributes.fetch(:status, :todo)
    task.assignee = attributes[:assignee]
    task.starts_on = attributes[:starts_on]
    task.due_on = attributes[:due_on]
    task.completed_at = attributes[:completed_at]
  end
end

seed_task(
  planning,
  "Set wedding date",
  position: 1,
  priority: :high,
  status: :done,
  completed_at: Time.current,
  assignee: owner
)

seed_task(
  planning,
  "Create guest list",
  position: 2,
  priority: :high,
  assignee: owner
)

seed_task(
  ceremony,
  "Book church",
  position: 1,
  priority: :critical
)

seed_task(
  reception,
  "Reserve venue",
  position: 1,
  priority: :critical
)
