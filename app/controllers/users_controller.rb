class UsersController < ApplicationController
  before_action :user, only: %i[show edit update destroy groups]
  before_action :authenticate_user!, except: %i[index show]

  def index
    @users = User.page(params[:page])
  end

  def show; end

  def edit
    authorize @user
  end

  def destroy
    authorize @user
    if @user.destroy
      redirect_to users_path
      flash[:danger] = "User profile \"#{@user.full_name}\" has been deleted"
    else
      flash.now[:warning] = 'Delete failed!'
    end
  end

  def update
    authorize @user
    if @user.update(user_params)
      flash[:success] = "User profile \"#{@user.full_name}\" updated"
      redirect_to @user
    else
      flash.now[:warning] = 'Invalid parameters for editing!'
      render :edit
    end
  end

  def groups
    @groups = @user.groups.page params[:page]
  end

  private

  def user_params
    params.require(:user).permit(:first_name,
                                 :last_name,
                                 :email,
                                 :password,
                                 :image)
  end

  def user
    @user = User.find(params[:id])
  end
end
