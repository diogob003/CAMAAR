class CreateTurmaAlunos < ActiveRecord::Migration[8.0]
  def change
    create_table :turma_alunos do |t|
      t.references :turma, foreign_key: true
      t.references :usuario, foreign_key: true
      t.timestamps
    end
  end
end
