# frozen_string_literal: true

# UserSavedQuestion model
class UserSavedQuestion < ApplicationRecord
  belongs_to :user
  belongs_to :question
end
