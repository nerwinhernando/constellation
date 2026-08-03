class PlanScopedController < WorkspaceScopedController
  before_action :set_plan

  private

  def set_plan
    @plan = @workspace.plans.find(params[:plan_id])
  end
end
