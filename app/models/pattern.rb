class Pattern < ApplicationRecord

  #enum
  enum pattern_type: {"休日": 1, "有休等":2, "出勤日":3}

  # Association
  has_many :shifts
end
