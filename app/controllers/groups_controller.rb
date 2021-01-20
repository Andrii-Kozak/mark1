class GroupsController < ApplicationController
  before_action :set_group, only: %i[show edit update destroy]

  def index
    @groups = Group.page params[:page]
  end

  def show; end

  def new
    @group = Group.new
  end

  def edit; end

  def create
    @group = Group.new(group_params)
    if @group.save
      flash[:success] = "group \"#{@group.group_name}\"  created"
      redirect_to groups_path
    else
      flash.now[:warning] = "Invalid parameters"
    end
  end

  def update
    if @group.update(group_params)
      flash[:success] = "group \"#{@group.group_name}\"  updated"
      redirect_to @group
    else
      flash.now[:warning] = 'Invalid parameters for editing!'
      render :edit
    end
  end

  def destroy
    if @group.destroy
      redirect_to [:groups]
      flash.now[:warning] = "Group \"#{@group.group_name}\" has been deleted"
    else
      flash.now[:danger] = 'Failed to delete group!'
    end
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