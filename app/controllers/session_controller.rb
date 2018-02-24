class SessionController < ApplicationController

  def new
  end

  def create
    @user = User.find_by_email(params[:signin][:email])
    if @user && @user.authenticate(params[:signin][:password])
      session[:user_id] = @user.id
      redirect_to '/'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end
end
