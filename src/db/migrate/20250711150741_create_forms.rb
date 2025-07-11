class CreateForms < ActiveRecord::Migration[8.0]
  def change
    create_table :forms do |t|
      t.date :open_date
      t.date :close_date

      t.timestamps
    end
  end
end
