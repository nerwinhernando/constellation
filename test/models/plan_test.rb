# frozen_string_literal: true

require "test_helper"

class PlanTest < ActiveSupport::TestCase
  setup do
    @plan = plans(:master)
  end

  test "is valid with valid attributes" do
    assert @plan.valid?
  end

  test "requires a title" do
    @plan.title = nil

    assert_not @plan.valid?
    assert_includes @plan.errors[:title], "can't be blank"
  end

  test "requires a status" do
    @plan.status = nil

    assert_not @plan.valid?
    assert_includes @plan.errors[:status], "can't be blank"
  end

  test "counts all tasks across phases" do
    assert_equal 4, @plan.total_tasks
  end

  test "counts completed tasks across phases" do
    assert_equal 1, @plan.completed_tasks
  end

  test "calculates completion percentage" do
    assert_equal 25, @plan.completion_percentage
  end

  test "calculates remaining tasks" do
    assert_equal 3, @plan.remaining_tasks
  end

  test "is not archived by default" do
    assert_not @plan.archived?
  end

  test "archives the plan" do
    @plan.archive!

    assert @plan.archived?
    assert_not_nil @plan.archived_at
  end

  test "loads ordered phases" do
    assert_equal %w[
      Planning
      Ceremony
      Reception
    ], @plan.ordered_phases.pluck(:title)
  end
end
