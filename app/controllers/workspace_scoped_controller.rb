class WorkspaceScopedController < ApplicationController
  before_action :require_authentication
  before_action :set_workspace

  private

  def set_workspace
    @workspace = Current.user.workspaces.find(params[:workspace_id])

    Current.workspace = @workspace
  end
end
