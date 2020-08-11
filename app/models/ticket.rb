class Ticket < ApplicationRecord
  belongs_to :project
  has_many :ticket_tags
  has_many :tags, through: :ticket_tags

  validates :name, presence: true, length: { minimum: 3 }, uniqueness: true
  validates :body, presence: true
  validates :status, presence: true
  validates :project_id, presence: true
end
