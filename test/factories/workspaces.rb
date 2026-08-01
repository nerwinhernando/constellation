FactoryBot.define do
  factory :workspace do
    name { "MyString" }
    slug { "MyString" }
    description { "MyText" }
    visibility { "MyString" }
    settings { "" }
    archived_at { "2026-08-01 16:30:13" }
    owner { nil }
  end
end
