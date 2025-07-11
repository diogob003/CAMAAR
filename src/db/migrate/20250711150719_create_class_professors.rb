class CreateClassProfessors < ActiveRecord::Migration[8.0]
  def change
    create_table :class_professors do |t|
      t.timestamps
    end
  end
end
