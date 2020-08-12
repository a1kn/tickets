class Comment < ApplicationRecord
  belongs_to :ticket
  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'
  validates :body, presence: true
  accepts_nested_attributes_for :ticket
end
