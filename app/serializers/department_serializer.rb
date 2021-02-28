class DepartmentSerializer < ActiveModel::Serializer
  attributes :id, :str, :mobile

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

  def mobile
    if object.id
      mobile = Department.find(object.id)
    end
    return mobile.name
  end
end