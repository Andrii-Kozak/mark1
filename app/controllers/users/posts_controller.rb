class Users::PostsController < PostsController
  private

  def redirect_to_postable
    render user_path(@postable)
  end

  def set_postable
    @postable = User.find(params[:user_id])
  end
end
