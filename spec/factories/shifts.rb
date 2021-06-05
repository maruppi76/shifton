FactoryBot.define do
  factory :shift do
    date      { '2021-12-31' }

    association :user
    association :pattern
    association :type
  end
end