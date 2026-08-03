class WorkspacesController < ApplicationController
  before_action :require_authentication

  def index
    @workspaces = Current.user.workspaces
  end

  def show
    @workspace = Current.user
                        .workspaces
                        .find_by!(slug: params[:id])
  end

  def new
    @workspace = Workspace.new
  end

  def create
    Workspace.transaction do
      @workspace = Current.user.owned_workspaces.build(workspace_params)
      @workspace.save!

      @workspace.memberships.create!(
        user: Current.user,
        role: :owner
      )
    end

    redirect_to @workspace, notice: "Workspace created."

  rescue ActiveRecord::RecordInvalid
    render :new, status: :unprocessable_entity
  end

  private

  def workspace_params
    params.require(:workspace)
          .permit(:name, :description, :visibility)
  end
end
