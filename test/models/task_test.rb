# frozen_string_literal: true

require "test_helper"

class TaskTest < ActiveSupport::TestCase
  setup do
    @task = tasks(:guest_list)
  end

  test "is valid with valid attributes" do
    assert @task.valid?
  end

  test "requires a title" do
    @task.title = nil

    assert_not @task.valid?
    assert_includes @task.errors[:title], "can't be blank"
  end

  test "requires a non-negative position" do
    @task.position = -1

    assert_not @task.valid?
  end

  test "is pending by default" do
    assert @task.pending?
    assert_not @task.completed?
  end

  test "complete! marks task as completed" do
    @task.complete!

    assert @task.completed?
    assert_equal "done", @task.status
    assert_not_nil @task.completed_at
  end

  test "reopen! clears completion" do
    @task.complete!
    @task.reopen!

    assert_not @task.completed?
    assert_equal "todo", @task.status
    assert_nil @task.completed_at
  end

  test "detects overdue task" do
    @task.update!(
      due_on: Date.yesterday,
      completed_at: nil
    )

    assert @task.overdue?
  end

  test "completed scope returns completed tasks" do
    assert_includes Task.completed, tasks(:set_date)
  end

  test "pending scope returns pending tasks" do
    assert_includes Task.pending, @task
  end

  test "complete! marks task completed" do
    task = tasks(:todo)

    task.complete!

    assert task.completed?
    assert_equal "done", task.status
  end

  test "reopen! reopens task" do
    task = tasks(:done)

    task.reopen!

    assert_not task.completed?
    assert_equal "todo", task.status
  end
end
