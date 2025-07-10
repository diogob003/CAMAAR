class CreateFormularios < ActiveRecord::Migration[8.0]
  def change
    create_table :formularios do |t|
      t.references :usuario_publicador, null: false, foreign_key: { to_table: :usuarios }
      t.references :template, null: false, foreign_key: true
      t.date :data_abertura
      t.date :data_fechamento

      t.timestamps
    end
  end
end
