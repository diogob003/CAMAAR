FactoryBot.define do
  factory :user do
    name { "Test User" }
    registration { "123456" }
    email { "pessoa123@example.com" }
    role { "student" }
    password { "password" }
  end
end
