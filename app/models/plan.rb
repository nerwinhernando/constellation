class Plan < ApplicationRecord
  belongs_to :workspace

  has_many :phases,
          -> { order(:position) },
          dependent: :destroy,
          inverse_of: :plan

  enum :status,
       {
         draft: "draft",
         active: "active",
         completed: "completed",
         archived: "archived"
       }

  validates :title, presence: true
  validates :status, presence: true

  scope :available,
      -> { where(archived_at: nil) }

  def ordered_phases
    phases.includes(tasks: :assignee)
  end

  def total_tasks
    Task.joins(:phase)
      .where(phases: { plan_id: id })
      .count
  end

  def completed_tasks
    Task.completed
      .joins(:phase)
      .where(phases: { plan_id: id })
      .count
  end

  def remaining_tasks
    total_tasks - completed_tasks
  end

  def completed?
    status_completed?
  end

  def completion_percentage
    return 0 if total_tasks.zero?

    ((completed_tasks.to_f / total_tasks) * 100).round
  end

  alias_method :progress, :completion_percentage

  def archived?
    archived_at.present?
  end

  def archive!
    update!(archived_at: Time.current)
  end
end
