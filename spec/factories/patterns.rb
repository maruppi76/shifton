FactoryBot.define do
  factory :pattern do
    pattern_type            { '出勤日' }
    name                    { '早番' }
    start_time              { '10:00' }
    end_time                { '19:00' }
    break_time              { '1:00' }
    actual_working_time     { '8:00' }
    remarks                 { 'hogehoge' }
  end
end
