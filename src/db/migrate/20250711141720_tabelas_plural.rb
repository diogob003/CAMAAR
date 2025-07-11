class TabelasPlural < ActiveRecord::Migration[8.0]
  def change
    rename_table :materia, :materias
    rename_table :opcaos, :opcoes
    rename_table :pergunta, :perguntas
    rename_table :resposta, :respostas
    rename_table :turma_professors, :turma_professores
  end
end
