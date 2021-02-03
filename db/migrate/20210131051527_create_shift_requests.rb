class CreateShiftRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :shift_requests do |t|
      t.date       :date,    null: false
      t.references :user,    null: false, forign_key: true
      t.references :pattern, null: false, forign_key: true
      t.integer    :status,  null: false, default: 0
      t.timestamps
    end
  end
end
