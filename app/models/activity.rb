class Activity < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true

  belongs_to :user

  has_many :tasks
  has_many :tags

  has_many :members
  has_many :users, through: :members
end
