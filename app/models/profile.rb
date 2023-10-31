class Profile < ApplicationRecord
  validates :display_name, presence: true

  belongs_to :user
  mount_uploader :image, ImageUploader
end
