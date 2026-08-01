  require "test_helper"

class PlanTest < ActiveSupport::TestCase
  test "is valid with valid attributes" do
    workspace = workspaces(:wedding)

    plan = Plan.new(
      workspace: workspace,
      title: "Master Plan"
    )

    assert plan.valid?
  end

  test "requires title" do
    workspace = workspaces(:wedding)

    plan = Plan.new(
      workspace: workspace
    )

    assert_not plan.valid?
    assert_includes plan.errors[:title], "can't be blank"
  end

  test "belongs to workspace" do
    plan = plans(:master)

    assert_equal workspaces(:wedding), plan.workspace
  end

  test "defaults to draft" do
    workspace = workspaces(:wedding)

    plan = workspace.plans.create!(
      title: "Planning"
    )

    assert_equal "draft", plan.status
  end

  test "can archive" do
    plan = plans(:master)

    plan.archive!

    assert plan.archived?
  end
end
