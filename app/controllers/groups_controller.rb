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
    @group.save

    redirect_to groups_path
  end

  def update
    if @group.update(group_params)
      flash[:success] = "group profile \"#{@group.group_name}\"  updated"
      redirect_to @group
    else
      render 'edit', warning: 'Invalid parameters for editing'
    end
  end

  def destroy
    @group.destroy
    redirect_to [:groups]
    flash[:danger] = "Group \"#{@group.group_name}\" with id:#{@group.id} has been deleted"
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:group_name,
                                  :description,
                                  :group_type)
  end
end
