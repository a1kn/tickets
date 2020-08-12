class Tag < ApplicationRecord
  has_many :ticket_tags, dependent: :destroy
  has_many :tickets, through: :ticket_tags, dependent: :destroy

  validates :name, presence: true, length: { minimum: 3 }, uniqueness: true
end
