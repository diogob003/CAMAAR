FactoryBot.define do
  factory :class_group do
    association :subject
    number { 1 }
    semester { "2025.1" }
  end
end
