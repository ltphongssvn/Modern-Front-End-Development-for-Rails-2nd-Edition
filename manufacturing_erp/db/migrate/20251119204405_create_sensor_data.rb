class CreateSensorData < ActiveRecord::Migration[8.0]
  def change
    create_table :sensor_data do |t|
      t.references :equipment, null: false, foreign_key: true
      t.references :production_line, null: false, foreign_key: true
      t.string :metric_type
      t.decimal :value
      t.string :unit
      t.datetime :recorded_at

      t.timestamps
    end
  end
end
