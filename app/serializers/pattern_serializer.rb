class PatternSerializer < ActiveModel::Serializer
  attributes :id, :name, :start_time, :end_time, :pattern_type
end
