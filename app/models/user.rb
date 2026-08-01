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

  validates :email_address, presence: true
  validates :username, presence: true

  normalizes :email_address, with: ->(e) { e.strip.downcase }
end
