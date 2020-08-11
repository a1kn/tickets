class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(strong_params)

    if @user.save
      flash[:success] = 'Welcome! You have successfully created an account.'
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render 'new'
    end
  end

  private

  def strong_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

  def find_project
    Project.find(params[:id])
  end
end
