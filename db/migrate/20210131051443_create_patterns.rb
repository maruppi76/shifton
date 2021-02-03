class CreatePatterns < ActiveRecord::Migration[6.0]
  def change
    create_table :patterns do |t|
      t.integer    :pattern_type,        null: false
      t.string     :name,                null: false
      t.time       :start_time
      t.time       :end_time
      t.time       :break_time
      t.time       :actual_working_time, null: false
      t.text       :remarks
      t.timestamps
    end
  end
end
