class CreateQualityChecks < ActiveRecord::Migration[8.0]
  def change
    create_table :quality_checks do |t|
      t.references :production_line, null: false, foreign_key: true
      t.references :equipment, null: false, foreign_key: true
      t.string :check_type
      t.string :result
      t.string :severity
      t.datetime :performed_at
      t.text :notes

      t.timestamps
    end
  end
end
