class PostPolicy
  attr_reader :user, :postable, :post

  def initialize(user, post)
    @user = user
    @post = post
    @postable = @post.postable
  end

  def destroy?
    case postable
    when User
      destroy_user_post?
    when Group
      destroy_group_post?
    end
  end

  private

  def admin_or_creator?
    user.admin? || user == post.creator
  end

  def destroy_user_post?
    admin_or_creator? || postable == user
  end

  def destroy_group_post?
    admin_or_creator? || postable.user_moderator?(user)
  end
end
