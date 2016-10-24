module PostsHelper
  def find_user_email(id)
    @user = User.find(id)
    @user.email
  end
end
