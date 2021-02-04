FactoryBot.define do
  factory :department do
    name { '本社' }
    ancestry { nil }

    association :company
  end
end
