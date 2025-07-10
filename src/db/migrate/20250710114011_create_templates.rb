class CreateTemplates < ActiveRecord::Migration[8.0]
  def change
    create_table :templates do |t|
      t.references :id_usuario_criador, null: false, foreign_key: true
      t.string :titulo
      t.text :descricao

      t.timestamps
    end
  end
end
