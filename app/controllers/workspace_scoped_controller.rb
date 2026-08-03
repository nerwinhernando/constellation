class WorkspaceScopedController < ApplicationController
  before_action :require_authentication
  before_action :set_workspace

  private

  def set_workspace
    @workspace = Current.user.workspaces.find_by!(slug: params[:workspace_id])
  end
end
