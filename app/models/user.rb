# frozen_string_literal: true

# User model
class User < ApplicationRecord
  has_secure_password

  enum gender: { other: 0, male: 1, female: 2 }

  has_many :questions # This are the user created questions

  has_many :user_saved_questions, dependent: :destroy
  has_many :questions, through: :user_saved_questions

  has_many :user_question_votes, dependent: :destroy
  has_many :questions, through: :user_question_votes

  has_many :user_answer_votes, dependent: :destroy
  has_many :answers, through: :user_answer_votes

  has_many :messages
  has_many :channels, through: :messages

  has_one :institution

  validates :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :identity_number, presence: true
  validates :name, presence: true
  validates :gender, presence: true
  validates :birth_date, presence: true
end
