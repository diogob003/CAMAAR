class AddAnsweredFormToAnswers < ActiveRecord::Migration[8.0]
  def change
    add_reference :answers, :answered_form, null: false, foreign_key: true
  end
end
