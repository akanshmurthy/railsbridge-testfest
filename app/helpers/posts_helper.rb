module PostsHelper
  def find_user_email(id)
    @user = User.find(id)
    @user.email
  end

  def initiate_twilio_client
  end

  def sent_text_to_user(number)
  end

end
