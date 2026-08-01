class Task < ApplicationRecord
  belongs_to :phase,
             inverse_of: :tasks

  belongs_to :assignee,
             class_name: "User",
             optional: true

  enum :status, {
    todo: "todo",
    doing: "doing",
    blocked: "blocked",
    done: "done"
  }

  enum :priority, {
    low: "low",
    normal: "normal",
    high: "high",
    critical: "critical"
  }

  validates :title, presence: true
  validates :position, numericality: {
                greater_than_or_equal_to: 0,
                only_integer: true
            }

  validates :status, presence: true
  validates :priority, presence: true

  scope :ordered, -> { order(:position) }
  scope :completed, -> { where.not(completed_at: nil) }
  scope :pending, -> { where(completed_at: nil) }
  scope :overdue, -> {
    pending.where("due_on < ?", Date.current)
  }

  def completed?
    completed_at.present?
  end

  def overdue?
    due_on.present? &&
      !completed? &&
      due_on < Date.current
  end

  def complete!
    update!(
      status: :done,
      completed_at: Time.current
    )
  end

  def reopen!
    update!(
      status: :todo,
      completed_at: nil
    )
  end
end
