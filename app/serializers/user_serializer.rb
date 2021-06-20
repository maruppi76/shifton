class UserSerializer < ActiveModel::Serializer
  attributes :id, :full_name, :full_name_kana, :first_name, :last_name, :first_name_kana, :last_name_kana, :email,	:staff_code,
             :status, :role, :admin

  belongs_to :company, serializer: CompanySerializer
  belongs_to :department_main, class_name: 'Department', serializer: DepartmentSerializer
  belongs_to :department_sub, class_name: 'Department', serializer: DepartmentSerializer

  def full_name
    object.first_name + ' ' + object.last_name
  end

  def full_name_kana
    object.first_name_kana + ' ' + object.last_name_kana
  end
end
