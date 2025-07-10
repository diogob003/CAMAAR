class CreateTemplates < ActiveRecord::Migration[8.0]
  def change
    create_table :templates do |t|
      t.references :usuario_criador, null: false, foreign_key: { to_table: :usuarios }
      t.string :titulo
      t.text :descricao

      t.timestamps
    end
  end
end
