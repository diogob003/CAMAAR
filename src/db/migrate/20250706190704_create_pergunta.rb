class CreatePergunta < ActiveRecord::Migration[8.0]
  def change
    create_table :pergunta do |t|
      t.string :titulo
      t.string :descricao
      t.references :template, foreign_key: true

      t.timestamps
    end
  end
end
