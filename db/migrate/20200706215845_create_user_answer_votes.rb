class CreateUserAnswerVotes < ActiveRecord::Migration[6.0]
  def change
    create_table :user_answer_votes do |t|
      t.boolean :negative, null: false
      t.references :user, null: false, foreign_key: true
      t.references :answer, null: false, foreign_key: true
    end
  end
end
