class DashboardController < ApplicationController
  before_action :require_authentication

  def show
    @workspaces = Current.user.workspaces
  end
end
