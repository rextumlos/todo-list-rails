class Task < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true

  belongs_to :user
  belongs_to :activity

  has_many :task_tag_ships
  has_many :tags, through: :task_tag_ships
end
