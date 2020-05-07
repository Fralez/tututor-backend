# frozen_string_literal: true

# User model
class User < ApplicationRecord
  acts_as_token_authenticatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum gender: { other: 0, male: 1, female: 2 }

  validates :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :identity_number, presence: true
  validates :name, presence: true
  validates :gender, presence: true
  validates :birth_date, presence: true
end
