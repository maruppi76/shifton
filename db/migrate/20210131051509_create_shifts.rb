class CreateShifts < ActiveRecord::Migration[6.0]
  def change
    create_table :shifts do |t|
      t.date       :date,    null: false
      t.references :user,    null: false, forign_key: true
      t.references :pattern, null: false, forign_key: true
      t.references :type,    forign_key: true
      t.timestamps
    end
  end
end
