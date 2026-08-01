class Phase < ApplicationRecord
  belongs_to :plan

  has_many :tasks,
           -> { order(:position) },
           dependent: :destroy

  validates :title, presence: true
  validates :position, numericality: {
    greater_than_or_equal_to: 0,
    only_integer: true
  }

  scope :ordered, -> { order(:position) }

  def progress
    return 0 if tasks.empty?

    ((tasks.completed.count.to_f / tasks.count) * 100).round
  end
end
