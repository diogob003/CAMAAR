class CreateTurmaProfessors < ActiveRecord::Migration[8.0]
  def change
    create_table :turma_professors do |t|
      t.references :professor, null: false, foreign_key: true
      t.references :turma, null: false, foreign_key: true

      t.timestamps
    end
  end
end
