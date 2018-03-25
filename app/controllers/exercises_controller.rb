class ExercisesController < ApplicationController
  def index
    @exercises = Exercise.all
  end

  def new
    @exercises = Exercise.new
  end

  def create
    @round = Round.find(params[:round_id])
    @exercises = @round.exercises.create(exercise_params)
    redirect_to exercises_path(@round)
  end

  def show
    @exercises = Excercise.find(params[:id])
  end

  private

  def exercise_params
    params.require(:exercise).permit(:name, :description, :weight, :reps)
  end
end
