class Users::PostsController < PostsController
  private

  def set_postable
    @postable = User.find(params[:user_id])
  end
end
