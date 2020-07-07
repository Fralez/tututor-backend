# frozen_string_literal: true

class QuestionCategory < ApplicationRecord
  has_many :category_to_questions
  has_many :questions, through: :category_to_questions

  validates :title, presence: true
end
