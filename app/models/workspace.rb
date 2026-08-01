class Workspace < ApplicationRecord
  belongs_to :owner, class_name: "User"
  has_many :invitations,
           dependent: :destroy

  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true

  enum :visibility,
    {
      private: "private",
      invite_only: "invite_only",
      public: "public"
    }, prefix: true

  before_validation :generate_slug, on: :create

  private

  def generate_slug
    return if slug.present?
    return if name.blank?

    self.slug = name.parameterize
  end
end
