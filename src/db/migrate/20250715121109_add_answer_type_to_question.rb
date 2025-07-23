class AddAnswerTypeToQuestion < ActiveRecord::Migration[8.0]
  def change
    add_column :questions, :answer_type, :string
  end
end
