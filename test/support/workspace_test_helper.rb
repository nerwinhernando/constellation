# frozen_string_literal: true

module WorkspaceTestHelper
  def wedding_workspace
    workspaces(:wedding)
  end

  def owner
    users(:alice)
  end

  def admin
    users(:bob)
  end

  def member
    users(:charlie)
  end

  def guest
    users(:diana)
  end
end
