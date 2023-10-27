class Activity < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true

  belongs_to :user

  has_many :tasks
  has_many :tags

  has_many :member_relations, class_name: 'Member'
  has_many :members, through: :member_relations, source: :user
end
