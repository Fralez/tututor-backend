# frozen_string_literal: true

# UserQuestionVote model
class UserQuestionVote < ApplicationRecord
  belongs_to :user
  belongs_to :question
end
