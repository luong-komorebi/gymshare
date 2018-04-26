class WorkoutPlansController < ApplicationController
  before_action :authorize, :except => [:index]

  def index
    @workout_plans = WorkoutPlan.order("score DESC")
    respond_to do |format|
      format.json { render :json => @workout_plans }
    end
  end

  def show
    @workout_plan = WorkoutPlan.find(params[:id])
    @round = Round.new
    @round.workout_plan_id = params[:id]
    respond_to do |format|
      format.json { render :json => @workout_plan }
    end
  end

  def new
    @workout_plans = WorkoutPlan.new
  end

  def create
    @workout_plans = current_user.workout_plans.create(workout_plans_params)
    
    if @workout_plans.save
      flash[:notice] = "Plan created successfully"
      flash[:color] = "valid"
    else
      flash[:notice] = "Plan not created successfully"
      flash[:color] = "invalid"
    end

    redirect_to workout_plan_path(@workout_plans)
  end

  private

  def workout_plans_params
    params.require(:workout_plan).permit(:name, :description)
  end
end
