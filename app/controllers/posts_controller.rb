class PostsController < ApplicationController
  # before_action :authenticate_user!
  # before_action :set_post, only: %i[update destroy]
  #
  # def create
  #   @post = current_user.posts.build(post_params)
  #   if @post.save
  #     flash.now[:success] = "Post #{@post.errors.messages}"
  #   else
  #     flash[:danger] = @post.errors.messages
  #   end
  # end
  #
  # def update; end
  #
  # def destroy
  #   if @post.user_creator?(current_user) || @post.postable.user_moderator?(current_user) || current_user.admin?
  #     @post.destroy if @post.present?
  #     flash[:danger] = "Post has been deleted"
  #   end
  # end
  #
  # private
  #
  # def post_params
  #   params.require(:post).permit(:image, :body)
  # end
  #
  # def set_post
  #   @post = Post.find(params[:id])
  # end
end
