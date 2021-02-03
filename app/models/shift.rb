class Shift < ApplicationRecord

  # Association
  belongs_to :user
  belongs_to :pattern
  belongs_to :type, optional: true
end
