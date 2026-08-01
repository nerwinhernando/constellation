FactoryBot.define do
  factory :invitation do
    workspace { nil }
    invited_by { nil }
    email { "MyString" }
    role { "MyString" }
    token { "MyString" }
    expires_at { "2026-08-01 17:14:11" }
    accepted_at { "2026-08-01 17:14:11" }
  end
end
