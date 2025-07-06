class CreateOpcaos < ActiveRecord::Migration[8.0]
  def change
    create_table :opcaos do |t|
      t.string :descricao
      t.integer :ordem
      t.references :pergunta, foreign_key: true

      t.timestamps
    end
  end
end
