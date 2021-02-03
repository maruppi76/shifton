class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  # enum
  enum role: { "全権管理者": 0, "シフト管理者": 1, "スタッフ": 2 }
  enum status: { "在籍中": 0, "休職中": 1, "退職": 2}

  # Association
  belongs_to :company
  belongs_to :department_main, class_name: "Department"
  belongs_to :department_sub, class_name: "Department", optional: true
  has_many :shifts
  has_many :shift_requests
  has_many :regal_holiday_requests
end
