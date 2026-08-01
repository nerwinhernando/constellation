class PlanTreeQuery
  def initialize(plan)
    @plan = plan
  end

  def call
    @plan
      .phases
      .includes(tasks: :assignee)
      .order(:position)
  end

  private

  attr_reader :plan
end
