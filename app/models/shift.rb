class Shift < ApplicationRecord
  # Validation
  validates :date, presence: true
  validates :type, presence: true, if: :pattern_with_work?

  def pattern_with_work?
    unless pattern
      return false
    end
    pattern.pattern_type == "出勤日"
  end

  # Association
  belongs_to :user
  belongs_to :pattern
  belongs_to :type, optional: true
end
