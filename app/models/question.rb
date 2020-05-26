class Question < ApplicationRecord
  belongs_to :user

  default_scope { order(created_at: :asc) }

  validates :title, presence: true
  validates :description, presence: true

  def creator
    User.find user_id
  end
end
