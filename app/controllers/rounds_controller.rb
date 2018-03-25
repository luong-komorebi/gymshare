class RoundsController < ApplicationController
  def create
    @round = Round.new(round_params)
    byebug
    @round.exercises.new(exercise_params[:exercises])
    @round.workout_plan_id = params[:workout_plan_id]
    @round.save
    redirect_to workout_plan_path(@round.workout_plan)
  end

  def new
    @round = Round.new
    byebug
    @round.exercises.build
  end

  private

  def round_params
    params.require(:round).permit(:repitition)
  end

  def exercise_params
    params.require(:round).permit(exercises: [ :name, :description, :weight, :reps ])
  end
end
