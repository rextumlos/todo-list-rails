class Activity < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true

  belongs_to :user

  has_many :tasks
  has_many :tags
end
