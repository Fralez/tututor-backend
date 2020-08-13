class CreateQuestionCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :question_categories do |t| 
      t.string :title, null: false
    end

    create_table :category_to_questions do |t|
      t.references :question_category, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
    end
  end
end
