class DepartmentSerializer < ActiveModel::Serializer
  attributes :id, :str

  def str
    str = ''
    if object.id
      arr = Department.find(object.id).path
      arr.each do |ele|
        if arr[0] == ele
          str = ele.name
        else
          str << ' > ' + ele.name
        end
      end
    end
    return str
  end
end