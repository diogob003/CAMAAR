class AddReferencesToModels < ActiveRecord::Migration[8.0]
  def change
    add_reference :class_professors, :professor, foreign_key: { to_table: :users }
    add_reference :class_professors, :class_group, foreign_key: true

    add_reference :class_students, :student, foreign_key: { to_table: :users }
    add_reference :class_students, :class_group, foreign_key: true

    add_reference :templates, :creator, foreign_key: { to_table: :users }

    add_reference :forms, :publisher, foreign_key: { to_table: :users }
    add_reference :forms, :template, foreign_key: true

    add_reference :class_forms, :class_group, foreign_key: true
    add_reference :class_forms, :form, foreign_key: true

    add_reference :questions, :template, foreign_key: true

    add_reference :options, :question, foreign_key: true

    add_reference :answered_forms, :user, foreign_key: true
    add_reference :answered_forms, :form, foreign_key: true

    add_reference :answers, :question, foreign_key: true
    add_reference :answers, :option, foreign_key: true
  end
end
