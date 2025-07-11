class CreateClassStudents < ActiveRecord::Migration[8.0]
  def change
    create_table :class_students do |t|
      t.timestamps
    end
  end
end
