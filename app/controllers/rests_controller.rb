class RestsController < ApplicationController
  def index
    @rests= Rest.all
    respond_to do |format|
      format.json { render :json => @rests }
    end
  end

  def new
    @rest = Rest.new
  end

  def show
  end

  def create
  end

end
