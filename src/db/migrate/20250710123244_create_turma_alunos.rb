class CreateTurmaAlunos < ActiveRecord::Migration[8.0]
  def change
    create_table :turma_alunos do |t|
      t.references :aluno, null: false, foreign_key: { to_table: :usuarios }
      t.references :turma, null: false, foreign_key: true

      t.timestamps
    end
  end
end
