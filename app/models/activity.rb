class Activity < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true

  belongs_to :user

  has_many :tasks
  has_many :tags

  has_many :member_relations, class_name: 'Member'
  has_many :members, through: :member_relations, source: :user

  scope :recent, -> { order(created_at: :desc) }
  scope :search_by_title, -> (title) { where('title LIKE :search', search: "%#{title}%") }

  # activity.own_and_associated_audits
  audited
  has_associated_audits

  include AASM

  aasm column: :state do
    state :pending, initial: true
    state :in_progress, :completed, :failed, :cancelled

    event :start do
      transitions from: :pending, to: :in_progress
    end

    event :complete do
      transitions from: :in_progress, to: :completed,
                  guard: :all_task_not_in_progress?,
                  success: :set_completed_date
    end

    event :fail do
      transitions from: :in_progress, to: :failed, guard: :all_task_not_in_progress?
    end

    event :cancel do
      transitions from: [:in_progress, :completed, :failed], to: :cancelled,
                  guard: :all_task_not_in_progress?,
                  success: :set_cancelled_date
    end

    event :retry do
      transitions from: [:in_progress, :completed, :failed, :cancelled], to: :pending,
                  guard: :all_task_not_in_progress?,
                  success: [:set_all_task_to_pending, :null_completed_cancelled_date]
    end
  end

  def all_task_not_in_progress?
    tasks.in_progress.empty?
  end

  def set_all_task_to_pending
    tasks.all.each do |task|
      task.retry!
    end
  end

  def set_completed_date
    update(completed_at: Time.current)
  end

  def set_cancelled_date
    update(cancelled_at: Time.current)
  end

  def null_completed_cancelled_date
    update(completed_at: nil, cancelled_at: nil)
  end
end
