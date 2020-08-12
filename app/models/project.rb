class Project < ApplicationRecord
  has_many :tickets, dependent: :destroy
  validates :name, presence: true, length: { minimum: 3 }, uniqueness: true
  validates :description, presence: true
end
