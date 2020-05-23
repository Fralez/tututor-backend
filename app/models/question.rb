class Question < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :description, presence: true

  def creator
    User.find user_id
  end
end
