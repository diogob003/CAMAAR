class CreateTemplates < ActiveRecord::Migration[8.0]
  def change
    create_table :templates do |t|
      t.string :titulo
      t.string :descricao
      t.references :usuario, foreign_key: true

      t.timestamps
    end
  end
end
