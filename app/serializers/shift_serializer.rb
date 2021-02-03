class ShiftSerializer < ActiveModel::Serializer
  attributes :id, :date, :user_id

  belongs_to :pattern, serializer: PatternSerializer
  belongs_to :type,    serializer: TypeSerializer
end
