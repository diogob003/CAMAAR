class CreateClassForms < ActiveRecord::Migration[8.0]
  def change
    create_table :class_forms do |t|
      t.timestamps
    end
  end
end
