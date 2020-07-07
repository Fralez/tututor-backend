class AddCorrectAnswerRefToQuestion < ActiveRecord::Migration[6.0]
  def change
    add_reference :questions, :correct_answer, foreign_key: { to_table: 'answers' }
  end
end
