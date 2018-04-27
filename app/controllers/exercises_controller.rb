class ExercisesController < ApplicationController
  def index
    @exercises = current_round.exercises
    respond_to do |format|
      format.json { render :json => @exercises }
    end
  end

  def new
    @exercises = Exercise.new
  end

  def create
    @exercise = current_round.exercises.build(exercise_params)
    render :json => @exercise
  end

  def show
    @exercise = current_round.find(params[:id])
    render @exercise
  end

  private

  def exercise_params
    params.require(:exercise).permit(:name, :description, :weight, :reps)
  end

  def current_round
    Round.find(params[:round_id])
  end
end
