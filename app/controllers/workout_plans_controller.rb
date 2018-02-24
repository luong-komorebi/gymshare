class WorkoutPlansController < ApplicationController
  def index
    @workout_plans = WorkoutPlan.all
  end
end
