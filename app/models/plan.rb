class Plan < ApplicationRecord
  belongs_to :workspace

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

  def archived?
    archived_at.present?
  end

  def archive!
    update!(archived_at: Time.current)
  end
end
