class Phase < ApplicationRecord
  belongs_to :plan,
           inverse_of: :phases

  has_many :tasks,
           -> { order(:position) },
           dependent: :destroy,
           inverse_of: :phase

  validates :title, presence: true
  validates :position, numericality: {
    greater_than_or_equal_to: 0,
    only_integer: true
  }

  scope :ordered, -> { order(:position) }

  def total_tasks
    tasks.count
  end

  def completed_tasks
    tasks.completed.count
  end

  def progress
    return 0 if tasks.empty?

    ((tasks.completed.count.to_f / tasks.count) * 100).round
  end

  def completion_percentage
    return 0 if total_tasks.zero?

    (completed_tasks * 100.0 / total_tasks).round
  end
end
