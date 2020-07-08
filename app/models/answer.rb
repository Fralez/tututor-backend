class Answer < ApplicationRecord
  default_scope { order(created_at: :desc) }

  belongs_to :question

  has_many :user_answer_votes, dependent: :destroy
  has_many :users, through: :user_answer_votes

  validates :description, presence: true

  def creator
    User.find user_id
  end

  def votes
    upvotes = UserAnswerVote.where(answer_id: id, negative: false).length
    downvotes = UserAnswerVote.where(answer_id: id, negative: true).length

    upvotes - downvotes
  end  
end