class Pattern < ApplicationRecord

  #enum
  enum pattern_type: {"休日": 1, "有休等":2, "出勤日":3}

  # Association
  has_many :shifts
  has_many :shift_requests
  has_many :regal_holiday_requests
end
