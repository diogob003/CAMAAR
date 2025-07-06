class CreateFormularios < ActiveRecord::Migration[8.0]
  def change
    create_table :formularios do |t|
      t.datetime :data_abertura
      t.datetime :data_fechamento
      t.references :template, foreign_key: true
      t.references :usuario, foreign_key: true

      t.timestamps
    end
  end
end
