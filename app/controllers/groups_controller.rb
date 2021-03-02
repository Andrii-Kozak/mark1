class GroupsController < ApplicationController
  GROUP_USERS_PREVIEW_AMOUNT = 4
  before_action :set_group, only: %i[show edit update destroy]
  before_action :set_group_members, only: %i[show]
  before_action :authenticate_user!, except: %i[index show]

  def index
    @groups = Group.ordered_by_created_at.page(params[:page])
  end

  def show
    @post = @group.posts.new
    @posts = @group.posts.with_creator
  end

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

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def set_group_members
    @group_members = User.by_joining_the_group(@group).limit(GROUP_USERS_PREVIEW_AMOUNT)
  end

  def group_params
    params.require(:group).permit(:group_name,
                                  :description,
                                  :group_type,
                                  :image)
  end
end
