FactoryBot.define do
  factory :user do
    first_name         { '山田' }
    last_name          { '太郎' }
    first_name_kana    { 'ヤマダ' }
    last_name_kana     { 'タロウ' }
    email              { 'taro.yamada@shifton.co.jp' }
    password           { '1a' + Faker::Internet.password(min_length: 4, max_length: 18) }
    staff_code         { 'A12345' }
    status             { 1 }
    role               { 1 }
    admin              { true }
    department_main_id { 1 }
    department_sub_id  { 1 }

    association :company
  end
end
