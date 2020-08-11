class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.username}!"
      redirect_to root_path
    else
      flash[:warning] = 'Username and/or password is incorrect.'
      redirect_to login_path
    end
  end

  def destroy
    if session[:user_id] != nil
      session[:user_id] = nil
      flash[:success] = "Logout successful."
      redirect_to login_path
    else
      flash[:warning] = "You were not logged in."
      redirect_to root_path
    end
  end
end
