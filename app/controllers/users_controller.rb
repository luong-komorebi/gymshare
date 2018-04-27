class UsersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
  skip_before_action :verify_authenticity_token

  def index
    @users = User.all
    respond_to do |format|
      format.json { render :json => @users }
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      render :json => @user
    else
      render :json => { :error => @user.errors.full_messages }, :status => 503
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      render :json => @user
    else
      render :json => { :error => @user.errors.full_messages }, :status => 503
    end
  end

  def show
    @user = User.find(params[:id])
    render :json => @user
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      render :json => { :message => "Deleted!"}
    else
      render :json => { :message => "User not existed!" }
    end
  end

  private
  def user_params
    permitted = params.permit(:email, :name, :password, :password_confirmation, :weight, :height, :age)
  end

  def record_not_found
    render :json => { :error => "Data Not found!" }, :status => 404
  end
end
