class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  # enum
  enum role: { "全権管理者": 0, "シフト管理者": 1, "スタッフ": 2 }
  enum status: { "在籍中": 0, "休職中": 1, "退職": 2}

  # Validation
  with_options presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]+\z/ } do
    validates :first_name
    validates :last_name
  end

  with_options presence: true, format: { with: /\A[\p{katakana}　ー－&&[^ -~｡-ﾟ]]+\z/ } do
    validates :first_name_kana
    validates :last_name_kana
  end


  with_options presence: true do
    validates :role
    validates :status
  end

  # Association
  belongs_to :company
  belongs_to :department_main, class_name: "Department"
  belongs_to :department_sub, class_name: "Department", optional: true
  has_many :shifts
end
