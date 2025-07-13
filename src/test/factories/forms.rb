FactoryBot.define do
  factory :form do
    open_date { Date.today }
    close_date { Date.today + 7 }
    association :publisher, factory: :user
    association :template
  end
end
