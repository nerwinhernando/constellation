class Invitation < ApplicationRecord
  belongs_to :workspace
  belongs_to :invited_by, class_name: "User"

  enum :role,
       {
         admin: "admin",
         member: "member",
         guest: "guest"
       }

  before_validation :generate_token, on: :create
  before_validation :set_expiration, on: :create

  validates :email, presence: true
  validates :token, uniqueness: true

  scope :pending, -> { where(accepted_at: nil) }

  def accepted?
    accepted_at.present?
  end

  def expired?
    expires_at.past?
  end

  private

  def generate_token
    self.token ||= SecureRandom.urlsafe_base64(32)
  end

  def set_expiration
    self.expires_at ||= 7.days.from_now
  end
end
