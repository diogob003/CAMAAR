class CreateOptions < ActiveRecord::Migration[8.0]
  def change
    create_table :options do |t|
      t.string :description
      t.integer :order

      t.timestamps
    end
  end
end
