class Institution < ApplicationRecord
  belongs_to :creator, class_name: "User", foreign_key: "creator_id"

  has_many :users

  validates :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :name, presence: true
  validates :address, presence: true

  def creator
    User.find creator_id
  end

  def users
    User.where.not(id: creator_id).where(institution_id: id)
  end
end
