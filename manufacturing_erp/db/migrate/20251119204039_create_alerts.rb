class CreateAlerts < ActiveRecord::Migration[8.0]
  def change
    create_table :alerts do |t|
      t.references :production_line, null: false, foreign_key: true
      t.references :equipment, null: false, foreign_key: true
      t.string :alert_type
      t.string :severity
      t.text :message
      t.string :status
      t.datetime :triggered_at
      t.datetime :resolved_at

      t.timestamps
    end
  end
end
