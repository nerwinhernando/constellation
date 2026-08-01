# frozen_string_literal: true

puts
puts "=" * 80
puts "Constellation Seeds"
puts "=" * 80

load Rails.root.join("db/seeds/users.rb")
load Rails.root.join("db/seeds/workspaces.rb")
load Rails.root.join("db/seeds/memberships.rb")

puts
puts "✅ Seed completed successfully."
puts "=" * 80
