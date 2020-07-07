class Question < ApplicationRecord
  default_scope { order(created_at: :desc) }

  belongs_to :user

  default_scope { order(created_at: :asc) }

  has_many :user_saved_questions
  has_many :users, through: :user_saved_questions

  has_many :user_question_votes
  has_many :users, through: :user_question_votes

  has_many :category_to_questions
  has_many :categories, through: :category_to_questions

  has_many :answers

  validates :title, presence: true
  validates :description, presence: true

  def creator
    User.find user_id
  end

  def votes
    upvotes = UserQuestionVote.where(question_id: id, negative: false).length
    downvotes = UserQuestionVote.where(question_id: id, negative: true).length

    upvotes - downvotes
  end

  def category
    category = CategoryToQuestion.where(question_id: id).first

    return unless category

    category_id = category.question_category_id
    QuestionCategory.find category_id
  end
end
