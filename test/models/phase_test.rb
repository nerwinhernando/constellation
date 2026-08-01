# frozen_string_literal: true

require "test_helper"

class PhaseTest < ActiveSupport::TestCase
  setup do
    @phase = phases(:planning)
  end

  test "is valid with valid attributes" do
    assert @phase.valid?
  end

  test "requires a title" do
    @phase.title = nil

    assert_not @phase.valid?
    assert_includes @phase.errors[:title], "can't be blank"
  end

  test "requires a non-negative position" do
    @phase.position = -1

    assert_not @phase.valid?
  end

  test "counts total tasks" do
    assert_equal 2, @phase.total_tasks
  end

  test "counts completed tasks" do
    assert_equal 1, @phase.completed_tasks
  end

  test "calculates completion percentage" do
    assert_equal 50, @phase.completion_percentage
  end

  test "orders tasks by position" do
    assert_equal %w[
      Set\ wedding\ date
      Create\ guest\ list
    ], @phase.tasks.ordered.pluck(:title)
  end
end
