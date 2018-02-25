class WorkoutPlansController < ApplicationController

  def index
    @workout_plans = WorkoutPlan.order("score DESC")
  end

  def show
    @workout_plans = WorkoutPlan.find(params[:id])
  end

  def new
    @workout_plans = WorkoutPlan.new
  end

  def create
    @workout_plans = WorkoutPlan.new(workout_plans_params)
    if @workout_plans.save
      flash[:notice] = "Plan created successfully"
      flash[:color] = "valid"
    else
      flash[:notice] = "Plan not created successfully"
      flash[:color] = "invalid"
    end

    redirect_to "new"
  end

  private

  def workout_plans_params
    params.require(workout_plans).permit()
  end
end
