class CreateMaintenanceSchedules < ActiveRecord::Migration[8.0]
  def change
    create_table :maintenance_schedules do |t|
      t.references :equipment, null: false, foreign_key: true
      t.datetime :scheduled_date
      t.string :maintenance_type
      t.text :description
      t.string :status
      t.datetime :completed_date

      t.timestamps
    end
  end
end
