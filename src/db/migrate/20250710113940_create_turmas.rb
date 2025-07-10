class CreateTurmas < ActiveRecord::Migration[8.0]
  def change
    create_table :turmas do |t|
      t.references :id_materia, null: false, foreign_key: true
      t.integer :numero
      t.string :semestre

      t.timestamps
    end
  end
end
