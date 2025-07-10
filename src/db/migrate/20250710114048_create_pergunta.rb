class CreatePergunta < ActiveRecord::Migration[8.0]
  def change
    create_table :pergunta do |t|
      t.references :id_template, null: false, foreign_key: true
      t.string :titulo
      t.text :descricao

      t.timestamps
    end
  end
end
