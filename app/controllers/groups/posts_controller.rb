class Groups::PostsController < PostsController
  private

  def set_postable
    @postable = Group.find(params[:group_id])
  end
end
