# frozen_string_literal: true

puts "Creating users..."

PASSWORD = "password123!"

USERS = [
  {
    email: "alice@example.com",
    username: "alice",
    name: "Alice Owner"
  },
  {
    email: "bob@example.com",
    username: "bob",
    name: "Bob Planner"
  },
  {
    email: "charlie@example.com",
    username: "charlie",
    name: "Charlie Photographer"
  },
  {
    email: "diana@example.com",
    username: "diana",
    name: "Diana Caterer"
  }
]

USERS.each do |attributes|
  user = User.find_or_initialize_by(email: attributes[:email])

  user.assign_attributes(
    name: attributes[:name],
    username: attributes[:username],
    password: PASSWORD,
    password_confirmation: PASSWORD,
    timezone: "Asia/Manila",
    locale: "en"
  )

  user.save!
end

puts "✓ #{User.count} users"
