class RestsController < ApplicationController
  def index
    @rests= current_round.all
    respond_to do |format|
      format.json { render :json => @rests }
    end
  end

  def new
    @rest = Rest.new
  end

  def show
    @rest = current_round.find(params[:id])
    render :json => @rest
  end

  def create
    @rest = current_round.rests.build(rest_params)
    render :json => @rest
  end

  private

  def current_round
    Round.find(params[:round_id])
  end

  def rest_params
    params.permit(:rest_time)
  end
end
