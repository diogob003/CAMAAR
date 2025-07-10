class CreateUsuarios < ActiveRecord::Migration[8.0]
  def change
    create_table :usuarios do |t|
      t.string :nome
      t.string :matricula
      t.string :email
      t.string :cargo
      t.string :senha_hash
      t.string :senha_salt

      t.timestamps
    end
  end
end
