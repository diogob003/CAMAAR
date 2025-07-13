FactoryBot.define do
  factory :question do
    title { "Sample Question" }
    description { "Question description" }
    association :template
    order { 1 }
  end
end
