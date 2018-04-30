class RoundsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
  skip_before_action :verify_authenticity_token

  def index
    @rounds = current_workout_plan.rounds
    render :json => @rounds
  end

  def show
    @round = current_workout_plan.rounds.find(params[:id])
    render :json => @round
  end

  def create
    logger.warn round_params
    logger.warn exercise_params
    @round = current_workout_plan.rounds.build(round_params)
    @round.exercises.new(exercise_params[:exercise])
    @round.workout_plan_id = params[:workout_plan_id]
    if @round.save
      render :json => @round
    else
      render :json => { :error => @round.errors.full_messages }, :status => 503
    end
  end

  def new
    @round = Round.new
    @round.exercises.build
  end

  def destroy
    @round = Round.find(params[:id])
    if @round.destroy
      render :json => { :message => "Deleted!"}
    else
      render :json => { :message => "Round not existed!" }
    end
  end

  private

  def round_params
    params.permit(:repitition)
  end

  def exercise_params
    params.permit(exercise: [ :name, :description, :weight, :reps ])
  end

  def record_not_found
    render :json => { :error => "Data Not found!" }, :status => 404
  end

  def current_workout_plan
    WorkoutPlan.find(params[:workout_plan_id])
  end
end
