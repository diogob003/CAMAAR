class CreateClassGroups < ActiveRecord::Migration[8.0]
  def change
    create_table :class_groups do |t|
      t.references :subject, null: false, foreign_key: true
      t.integer :number
      t.string :semester

      t.timestamps
    end
  end
end
