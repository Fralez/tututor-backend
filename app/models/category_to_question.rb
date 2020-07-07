class CategoryToQuestion < ApplicationRecord
  belongs_to :question_category
  belongs_to :question
end
