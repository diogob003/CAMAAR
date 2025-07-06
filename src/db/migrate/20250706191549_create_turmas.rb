class CreateTurmas < ActiveRecord::Migration[8.0]
  def change
    create_table :turmas do |t|
      t.integer :numero
      t.string :semestre
      t.references :materia, foreign_key: true

      t.timestamps
    end
  end
end
