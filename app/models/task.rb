class Task < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true

  belongs_to :user
  belongs_to :activity

  has_many :task_tag_ships
  has_many :tags, through: :task_tag_ships

  has_many :assigned_member_relations, class_name: 'AssignedMember'
  has_many :assigned_members, through: :assigned_member_relations, source: :user

  scope :recent, -> { order(created_at: :desc) }
  scope :search_by_title, -> (title) { where('title LIKE :search', search: "%#{title}%") }

  audited associated_with: :activity

  include AASM
  
  aasm column: :state do
    state :pending, initial: true
    state :in_progress, :completed, :failed, :cancelled

    event :start do
      transitions from: :pending, to: :in_progress, after: :set_activity_in_progress
    end

    event :complete do
      transitions from: :in_progress, to: :completed, after: :set_completed_date
    end

    event :fail do
      transitions from: :in_progress, to: :failed
    end

    event :cancel do
      transitions from: [:in_progress, :completed, :failed], to: :cancelled, after: :set_cancelled_date
    end

    event :retry do
      transitions from: :failed, to: :pending, after: :null_completed_cancelled_date
    end
  end

  def set_completed_date
    update(completed_at: DateTime.now)
  end

  def set_cancelled_date
    update(cancelled_at: DateTime.now)
  end

  def set_activity_in_progress
    activity.start! if activity.may_start?
  end

  def null_completed_cancelled_date
    update(completed_at: nil, cancelled_at: nil)
  end
end
