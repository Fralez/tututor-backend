class Question < ApplicationRecord
  belongs_to :user

  has_many :category_to_questions 
  has_many :categories, through: :category_to_questions

  default_scope { order(created_at: :asc) }

  validates :title, presence: true
  validates :description, presence: true

  def creator
    User.find user_id
  end
end
