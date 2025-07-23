FactoryBot.define do
  factory :class_professor do
    association :class_group
    association :professor
  end
end
