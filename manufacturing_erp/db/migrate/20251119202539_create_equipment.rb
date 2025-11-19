class CreateEquipment < ActiveRecord::Migration[8.0]
  def change
    create_table :equipment do |t|
      t.string :name
      t.string :serial_number
      t.references :production_line, null: false, foreign_key: true
      t.string :status
      t.datetime :last_maintenance
      t.datetime :next_maintenance
      t.integer :operating_hours

      t.timestamps
    end
  end
end
