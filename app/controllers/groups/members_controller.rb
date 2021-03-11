class Groups::MembersController < ApplicationController
  GROUP_USERS_PREVIEW_AMOUNT = 4
  before_action :authenticate_user!
  before_action :set_group
  before_action :set_group_members

  def index
    @users = User.by_joining_the_group(@group).page(params[:page])
  end

  def show; end

  def create
    @group.user_groups.create(user_id: current_user.id)
    render 'groups/members/follow_btn'
  end

  def destroy
    @group.user_groups.find_by(user_id: current_user.id).destroy
    render 'groups/members/follow_btn'
  end

  def remove_member
    if @group.user_moderator?(current_user) || current_user.admin?
      @group.user_groups.find_by(user_id: params[:member_id]).destroy
      flash[:warning] = 'User has been removed from group!'
      redirect_to group_members_path
    else
      flash[:warning] = 'Access denied'
      render 'groups/user_members'
    end
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end

  def set_group_members
    @group_members = User.by_joining_the_group(@group).limit(GROUP_USERS_PREVIEW_AMOUNT)
  end
end
