class WorkoutPlansController < ApplicationController
  before_action :authorize, :except => [:index]
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
  skip_before_action :verify_authenticity_token

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

  def update
    @workout_plan = WorkoutPlan.find(params[:id])
    if @workout_plan.update_attributes(workout_plans_params)
      render :json => @workout_plan
    else
      render :json => { :error => @workout_plan.errors.full_messages }, :status => 503
    end
  end

  def create
    @workout_plan = current_user.workout_plans.create(workout_plans_params)
    if @workout_plan.save
      render :json => @workout_plan
    else
      render :json => { :error => @workout_plan.errors.full_messages }, :status => 503
    end
  end

  def destroy
    @workout_plan = WorkoutPlan.find(params[:id])
    if @workout_plan.destroy
      render :json => { :message => "Deleted!"}
    else
      render :json => { :message => "WorkoutPlan not existed!" }
    end
  end

  private

  def workout_plans_params
    params.permit(:name, :description, :score)
  end

  def record_not_found
    render :json => { :error => "Data Not found!" }, :status => 404
  end
end
