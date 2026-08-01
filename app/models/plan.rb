class Plan < ApplicationRecord
  belongs_to :workspace

  has_many :phases,
         -> { order(:position) },
         dependent: :destroy

  enum :status,
       {
         draft: "draft",
         active: "active",
         completed: "completed",
         archived: "archived"
       }

  validates :title, presence: true
  validates :status, presence: true

  scope :active_records,
        -> { where(archived_at: nil) }

  def ordered_phases
    phases.includes(:tasks)
  end

  def total_tasks
    phases.joins(:tasks).count
  end

  def completed_tasks
    phases.joins(:tasks)
          .merge(Task.completed)
          .count
  end

  def completion_percentage
    return 0 if total_tasks.zero?

    ((completed_tasks.to_f / total_tasks) * 100).round
  end

  def archived?
    archived_at.present?
  end

  def archive!
    update!(archived_at: Time.current)
  end
end
