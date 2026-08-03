class PhaseScopedController < PlanScopedController
  before_action :set_phase

  private

  def set_phase
    @phase = @plan.phases.find(params[:phase_id])
  end
end
