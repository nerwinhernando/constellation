class Current < ActiveSupport::CurrentAttributes
  attribute :session
  attribute :workspace
  delegate :user, to: :session, allow_nil: true

  def membership
    return unless user && workspace

    @membership ||= Membership.find_by(
      workspace: workspace,
      user: user
    )
  end

  def reset_membership!
    @membership = nil
  end
end
