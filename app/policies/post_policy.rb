class PostPolicy
  attr_reader :user, :postable, :post

  def initialize(user, post)
    @user = user
    @post = post
    @postable = @post.postable
  end

  def destroy?
    if postable.instance_of?(User)
      destroy_user_post?
    elsif postable.instance_of?(Group)
      destroy_group_post?
    else
      false
    end
  end

  private

  def destroy_user_post?
    user.admin? || postable == user || user == post.creator
  end

  def destroy_group_post?
    user.admin? || postable.user_moderator?(user) || user == post.creator
  end
end
