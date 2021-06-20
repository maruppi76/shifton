class Department < ApplicationRecord
  has_ancestry
  # Association
  belongs_to :company
  has_many :main_users, class_name: 'User', foreign_key: 'department_main_id'
  has_many :sub_users, class_name: 'User', foreign_key: 'department_sub_id'
end
