class CreateProductionLines < ActiveRecord::Migration[8.0]
  def change
    create_table :production_lines do |t|
      t.string :name
      t.string :status
      t.integer :capacity
      t.integer :current_output
      t.decimal :efficiency
      t.string :location

      t.timestamps
    end
  end
end
