FactoryBot.define do
  factory :plan do
    workspace { nil }
    title { "MyString" }
    description { "MyText" }
    status { "MyString" }
    starts_on { "2026-08-01" }
    ends_on { "2026-08-01" }
    settings { "" }
    archived_at { "2026-08-01 18:27:26" }
  end
end
