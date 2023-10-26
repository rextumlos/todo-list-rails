class Tag < ApplicationRecord
  validates :name, presence: true

  belongs_to :activity

  has_many :task_tag_ships
  has_many :tasks, through: :task_tag_ships
end
