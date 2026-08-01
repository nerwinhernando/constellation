class PlansController < WorkspaceScopedController
  include Pundit::Authorization

  before_action :set_plan, only: %i[
    show
    edit
    update
    destroy
  ]

  after_action :verify_authorized
  after_action :verify_policy_scoped, only: :index

  def index
    @plans = policy_scope(@workspace.plans)
               .order(created_at: :desc)
  end

  def show
    authorize @plan
  end

  def new
    @plan = @workspace.plans.new

    authorize @plan
  end

  def create
    @plan = @workspace.plans.new(plan_params)

    authorize @plan

    if @plan.save
      redirect_to(
        [@workspace, @plan],
        notice: "Plan created successfully."
      )
    else
      render :new,
             status: :unprocessable_entity
    end
  end

  def edit
    authorize @plan
  end

  def update
    authorize @plan

    if @plan.update(plan_params)
      redirect_to(
        [@workspace, @plan],
        notice: "Plan updated successfully."
      )
    else
      render :edit,
             status: :unprocessable_entity
    end
  end

  def destroy
    authorize @plan

    @plan.destroy!

    redirect_to(
      workspace_plans_path(@workspace),
      notice: "Plan deleted."
    )
  end

  private

  def set_plan
    @plan = @workspace.plans.find(params[:id])
  end

  def plan_params
    params
      .require(:plan)
      .permit(
        :title,
        :description,
        :status,
        :starts_on,
        :ends_on
      )
  end
end
