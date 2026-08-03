class PhasesController < ApplicationController
  before_action :require_authentication
  before_action :set_workspace
  before_action :set_plan
  before_action :set_phase, only: %i[edit update destroy]

  def new
    @phase = @plan.phases.build(position: next_position)
  end

  def create
    @phase = @plan.phases.build(phase_params)

    if @phase.save
      redirect_to [@workspace, @plan],
                  notice: "Phase created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @phase.update(phase_params)
      redirect_to [@workspace, @plan],
                  notice: "Phase updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @phase.destroy

    redirect_to [@workspace, @plan],
                notice: "Phase deleted."
  end

  private

  def set_workspace
    @workspace = Current.user.workspaces.find_by!(slug: params[:workspace_id])
  end

  def set_plan
    @plan = @workspace.plans.find(params[:plan_id])
  end

  def set_phase
    @phase = @plan.phases.find(params[:id])
  end

  def phase_params
    params.require(:phase)
          .permit(:title, :position)
  end

  def next_position
    @plan.phases.maximum(:position).to_i + 1
  end
end
