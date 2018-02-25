class UsersController < ApplicationController

  def index
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
      redirect_to user_path(@user)
    else
      flash[:error] = "Form is invalid"
      flash[:color] = "invalid"
      render "new"
    end

   
  end

  def show
    @user = User.find(params[:id])
  end

  private
  def user_params
    permitted = params.require(:user).permit(:email, :name, :password, :password_confirmation)
  end
end
