FactoryBot.define do
  factory :class_form do
    association :form
    association :class_group
  end
end