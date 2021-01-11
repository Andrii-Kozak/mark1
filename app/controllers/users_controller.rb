class UsersController < ApplicationController
  before_action :user, only: %i[show edit update destroy]

  def index
    @users = User.page params[:page]
  end

  def show; end

  def edit; end

  def destroy
    if @user.destroy
      redirect_to users_path
      flash[:danger] = "User profile has been deleted"
    else
      flash.now[:warning] = 'Delete failed!'
    end
  end

  def update
    if @user.update(user_params)
      flash[:success] = "User profile \"#{@user.full_name}\" updated"
      redirect_to @user
    else
      flash.now[:warning] = 'Invalid parameters for editing!'
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name,
                                 :last_name,
                                 :email,
                                 :password)
  end

  def user
    @user ||= User.find(params[:id])
  end
end
