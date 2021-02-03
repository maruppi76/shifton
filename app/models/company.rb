class Company < ApplicationRecord

  # Association
  has_many :users
  has_many :departments
end
