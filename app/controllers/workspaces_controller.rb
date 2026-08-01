class WorkspacesController < ApplicationController
  before_action :require_authentication

  def index
    @workspaces = Current.user.workspaces
  end

  def show
    @workspace = Current.user
                        .workspaces
                        .find(params[:id])
  end

  def new
    @workspace = Workspace.new
  end

  def create
    @workspace = Current.user.owned_workspaces.build(workspace_params)

    if @workspace.save
      redirect_to @workspace,
                  notice: "Workspace created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def workspace_params
    params.require(:workspace)
          .permit(:name, :description, :visibility)
  end
end
