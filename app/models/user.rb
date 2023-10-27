class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :profile
  accepts_nested_attributes_for :profile

  has_many :activities
  has_many :tasks

  has_many :members
  has_many :activities, through: :members

  has_many :assigned_members
  has_many :tasks, through: :assigned_members
end
