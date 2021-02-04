FactoryBot.define do
  factory :department do
    id { 1 }
    name { '本社' }
    ancestry { '' }

    association :company
  end
end
