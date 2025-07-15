FactoryBot.define do
  factory :template do
    title { "Sample Template" }
    description { "Template description" }
    association :creator, factory: :user
  end
end
