class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :registration
      t.string :email
      t.string :role
      t.string :password_hash
      t.string :password_salt

      t.timestamps
    end
  end
end
