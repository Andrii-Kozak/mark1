class GroupsController < ApplicationController
  before_action :set_group, only: %i[show edit update destroy members]
  before_action :authenticate_user!, except: %i[index show]

  def index
    @groups = Group.page(params[:page])
  end

  def show; end

  def new
    @group = Group.new
  end

  def edit
    unless @group.user_moderator?(current_user) || current_user.admin?
      flash[:warning] = "Access denied"
      render :show
    end
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      @group.user_groups.create(user_id: current_user.id, moderator: true)
      flash[:success] = "group \"#{@group.group_name}\" created"
      redirect_to @group
    else
      flash[:warning] = "Invalid parameters"
      render :new
    end
  end

  def update # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    if @group.user_moderator?(current_user) || current_user.admin?
      if @group.update(group_params)
        flash[:success] = "group \"#{@group.group_name}\"  updated"
        redirect_to @group
      else
        flash[:warning] = 'Invalid parameters for editing!'
        render :edit
      end
    else
      flash[:warning] = "Access denied"
      render :show
    end
  end

  def destroy
    @group.destroy
    redirect_to [:groups]
    flash[:warning] = "Group \"#{@group.group_name}\" has been deleted"
  end

  def members
    @users = @group.users.page(params[:page])
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:group_name,
                                  :description,
                                  :group_type,
                                  :image)
  end
end
