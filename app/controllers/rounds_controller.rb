class RoundsController < ApplicationController
  def create
    @round = Round.new(round_params)
    @round.workout_plan_id = params[:workout_plan_id]
    @round.save

    redirect_to workout_plan_path(@round.workout_plan)
  end

  private
  def round_params
    params.require(:round).permit(:repitition)
  end
end
