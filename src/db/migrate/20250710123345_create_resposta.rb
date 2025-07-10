class CreateResposta < ActiveRecord::Migration[8.0]
  def change
    create_table :resposta do |t|
      t.references :pergunta, null: false, foreign_key: true
      t.references :opcao, null: true, foreign_key: true
      t.text :justificativa

      t.timestamps
    end
  end
end
