module UsersHelper
  # does user have posts or comments
  def user_has_comments_or_posts?(user)
    user.posts.any? || user.comments.any?
  end
end
