class CreateResposta < ActiveRecord::Migration[8.0]
  def change
    create_table :resposta do |t|
      t.references :id_pergunta, null: false, foreign_key: true
      t.references :id_opcao, null: false, foreign_key: true
      t.text :justificativa

      t.timestamps
    end
  end
end
