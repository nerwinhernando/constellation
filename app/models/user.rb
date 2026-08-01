class User < ApplicationRecord
  has_secure_password

  has_many :sessions, dependent: :destroy

  has_many :memberships, dependent: :destroy
  has_many :workspaces, through: :memberships
  has_many :owned_workspaces,
            class_name: "Workspace",
            foreign_key: "owner_id",
            dependent: :restrict_with_exception

  has_many :business_profiles, dependent: :destroy
  has_many :sent_invitations,
           class_name: "Invitation",
           foreign_key: :invited_by_id,
           dependent: :nullify

  validates :email,
          presence: true,
          uniqueness: {
            case_sensitive: false
          }
  validates :username,
          presence: true,
          uniqueness: {
            case_sensitive: false
          }

  normalizes :email, with: ->(e) { e.strip.downcase }

  def display_name
    username.presence || email
  end
end
