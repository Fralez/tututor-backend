class Question < ApplicationRecord
  default_scope { order(created_at: :desc) }

  belongs_to :user

  has_many :user_saved_questions
  has_many :users, through: :user_saved_questions

  has_many :user_question_votes
  has_many :users, through: :user_question_votes

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
end
