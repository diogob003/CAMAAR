class CreateOpcaos < ActiveRecord::Migration[8.0]
  def change
    create_table :opcaos do |t|
      t.references :id_pergunta, null: false, foreign_key: true
      t.string :descricao
      t.integer :ordem

      t.timestamps
    end
  end
end
