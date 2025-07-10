class CreateTurmaFormularios < ActiveRecord::Migration[8.0]
  def change
    create_table :turma_formularios do |t|
      t.references :turma, null: false, foreign_key: true
      t.references :formulario, null: false, foreign_key: true

      t.timestamps
    end
  end
end
