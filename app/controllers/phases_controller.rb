class PhasesController < PlanScopedController
  before_action :set_phase, only: %i[edit update destroy]

  def new
    @phase = @plan.phases.build(position: next_position)
  end

  def create
    @phase = @plan.phases.build(
      phase_params.merge(
        position: @plan.phases.maximum(:position).to_i + 1
      )
    )

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
