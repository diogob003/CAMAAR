class CreateResposta < ActiveRecord::Migration[8.0]
  def change
    create_table :resposta do |t|
      t.string :justificativa
      t.references :pergunta, foreign_key: true
      t.references :opcao, foreign_key: true, null: true

      t.timestamps
    end
  end
end
