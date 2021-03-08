class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_postable, only: %i[create destroy]

  def create
    @post = @postable.posts.build(post_params)
    @post.creator = current_user
    if @post.save
      flash[:success] = "Post successfully created"
    else
      flash[:danger] = @post.errors.full_messages.join(', ')
    end
    redirect_to @postable
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    if @post
      @post.destroy!
      flash[:danger] = "Post has been deleted"
      redirect_to @postable
    end
  end

  private

  def post_params
    params.require(:post).permit(:image, :body)
  end

  def set_postable
    raise NotImplementedError
  end
end
