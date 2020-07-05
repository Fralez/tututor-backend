class CreateUserSavedQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :user_saved_questions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
    end
  end
end
