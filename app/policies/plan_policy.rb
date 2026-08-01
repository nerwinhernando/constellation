class PlanPolicy < ApplicationPolicy
  def index?
    member?
  end

  def show?
    member?
  end

  def create?
    owner_or_admin?
  end

  def update?
    owner_or_admin?
  end

  def destroy?
    owner?
  end

  private

  def membership
    @membership ||= Membership.find_by(
      workspace: record.workspace,
      user: user
    )
  end

  def member?
    membership.present?
  end

  def owner?
    membership&.owner?
  end

  def owner_or_admin?
    membership&.owner_or_admin?
  end
end
