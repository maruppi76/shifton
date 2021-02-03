class RegalHolidayRequest < ApplicationRecord

  # Association
  belongs_to :user
  belongs_to :pattern
end
