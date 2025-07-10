class CreateFormularios < ActiveRecord::Migration[8.0]
  def change
    create_table :formularios do |t|
      t.references :id_usuario_publicador, null: false, foreign_key: true
      t.references :id_template, null: false, foreign_key: true
      t.date :data_abertura
      t.date :data_fechamento

      t.timestamps
    end
  end
end
