FactoryBot.define do
  factory :answered_form do
    association :user
    association :form
  end
end
