# frozen_string_literal: true

class Channel < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :users, through: :messages
  validates :name, presence: true, uniqueness: true, case_sensitive: false
end
