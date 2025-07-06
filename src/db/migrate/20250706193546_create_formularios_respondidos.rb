class CreateFormulariosRespondidos < ActiveRecord::Migration[8.0]
  def change
    create_table :formularios_respondidos do |t|
      t.references :formulario, foreign_key: true
      t.references :usuario, foreign_key: true
      t.timestamps
    end
  end
end
