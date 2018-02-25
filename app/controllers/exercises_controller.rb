class ExercisesController < ApplicationController
  def index
    @exercises = Exercise.all
  end

  def new
    @exercises = Excercise.new
  end

  def create
  end

  def show
    @exercises = Excercise.find(params[:id])
end
