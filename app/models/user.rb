class User < ApplicationRecord
  has_secure_password
  has_many :tickets, foreign_key: 'user_id'
  has_many :assigned_tickets, class_name: 'Ticket', foreign_key: 'assignee_id'
  has_many :comments, foreign_key: 'creator_id'
end
