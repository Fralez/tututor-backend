class CreateUserQuestionVotes < ActiveRecord::Migration[6.0]
  def change
    create_table :user_question_votes do |t|
      t.boolean :negative, null: false
      t.references :user, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
    end
  end
end
