# frozen_string_literal: true

# UserAnswerVote model
class UserAnswerVote < ApplicationRecord
  belongs_to :user
  belongs_to :answer
end
