class Membership < ApplicationRecord
  belongs_to :workspace
  belongs_to :user

  enum :role,
      {
        owner: "owner",
        admin: "admin",
        member: "member",
        guest: "guest"
      }

  validates :role, presence: true

  validates :user_id,
            uniqueness: {
              scope: :workspace_id
            }

  before_create :set_joined_at

  def owner_or_admin?
    owner? || admin?
  end

  def can_manage_workspace?
    owner_or_admin?
  end

  def can_manage_plans?
    owner_or_admin?
  end

  def can_invite_members?
    owner_or_admin?
  end

  def can_manage_marketplace?
    owner_or_admin?
  end

  private

  def set_joined_at
    self.joined_at ||= Time.current
  end
end
