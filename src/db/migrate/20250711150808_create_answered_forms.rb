class CreateAnsweredForms < ActiveRecord::Migration[8.0]
  def change
    create_table :answered_forms do |t|
      t.timestamps
    end
  end
end
