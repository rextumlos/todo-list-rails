class Task < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true

  belongs_to :user
  belongs_to :activity

  has_many :task_tag_ships
  has_many :tags, through: :task_tag_ships

  has_many :assigned_member_relations, class_name: 'AssignedMember'
  has_many :assigned_members, through: :assigned_member_relations, source: :user
end
