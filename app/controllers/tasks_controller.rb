# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :require_authentication
  before_action :set_workspace
  before_action :set_plan
  before_action :set_phase
  before_action :set_task, only: %i[
    edit
    update
    destroy
    complete
    reopen
  ]

  def new
    @task = @phase.tasks.build(position: next_position)
  end

  def create
    @task = @phase.tasks.build(
      task_params.merge(
        position: @phase.tasks.maximum(:position).to_i + 1
      )
    )

    if @task.save
      respond_to do |format|
        format.html do
          redirect_to [ @workspace, @plan ],
                      notice: "Task created successfully."
        end

        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      respond_to do |format|
        format.html do
          redirect_to [ @workspace, @plan ],
                      notice: "Task updated successfully."
        end

        format.turbo_stream
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy

    respond_to do |format|
      format.html do
        redirect_to [ @workspace, @plan ],
                    notice: "Task deleted."
      end

      format.turbo_stream
    end
  end

  def complete
    @task.complete!

    respond_to do |format|
      format.html do
        redirect_to [ @workspace, @plan ],
                    notice: "Task completed."
      end

      format.turbo_stream
    end
  end

  def reopen
    @task.reopen!

    respond_to do |format|
      format.html do
        redirect_to [ @workspace, @plan ],
                    notice: "Task reopened."
      end

      format.turbo_stream
    end
  end

  private

  def set_workspace
    @workspace = Current.user.workspaces.find_by!(slug: params[:workspace_id])
  end

  def set_plan
    @plan = @workspace.plans.find(params[:plan_id])
  end

  def set_phase
    @phase = @plan.phases.find(params[:phase_id])
  end

  def set_task
    @task = @phase.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(
      :title,
      :description,
      :priority,
      :status,
      :due_on,
      :position
    )
  end

  def next_position
    @phase.tasks.maximum(:position).to_i + 1
  end
end
