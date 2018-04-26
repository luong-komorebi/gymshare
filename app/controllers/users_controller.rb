class UsersController < ApplicationController
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
      flash[:notice] = "You have signed up successfully"
      flash[:color] = "valid"
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

  private
  def user_params
    permitted = params.permit(:email, :name, :password, :password_confirmation, :weight, :height, :age)
  end
end
