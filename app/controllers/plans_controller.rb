# app/controllers/plans_controller.rb

class PlansController < WorkspaceScopedController
  before_action :set_plan, only: %i[
    show
  ]

  def show
    @phases = PlanTreeQuery.new(@plan).call
  end

  def new
    @plan = @workspace.plans.build
  end

  def create
    @plan = @workspace.plans.build(plan_params)

    if @plan.save
      redirect_to [ @workspace, @plan ],
                  notice: "Plan created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_plan
    @plan = @workspace.plans.find(params[:id])
  end

  def plan_params
    params.require(:plan)
          .permit(
            :title,
            :description,
            :status,
            :starts_on,
            :ends_on
          )
  end
end
