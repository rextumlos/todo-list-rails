class Profile < ApplicationRecord
  validates :display_name, presence: true

  belongs_to :user
end
