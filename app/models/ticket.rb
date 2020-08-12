class Ticket < ApplicationRecord
  belongs_to :project
  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
  belongs_to :assignee, class_name: 'User', foreign_key: 'assignee_id'
  has_many :ticket_tags, dependent: :destroy
  has_many :tags, through: :ticket_tags, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :name, presence: true, length: { minimum: 3 }, uniqueness: true
  validates :project_id, presence: true
  validates :body, presence: true
  validates :assignee_id, presence: true
  validates :status, presence: true

  scope :filter_by_project, -> (project_id) { where project_id: project_id }
  scope :filter_by_status, -> (status) { where status: status }
  scope :filter_by_tag, -> (tag_id) { joins(:ticket_tags).where('tag_id = ?', tag_id) }
end
