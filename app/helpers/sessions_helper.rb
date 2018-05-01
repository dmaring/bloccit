module SessionsHelper
  # session is an object that Rails provides to track the state of the user
  def create_session(user)
    session[:user_id] = user.id
  end

  # clear the user id on the session object by setting it to nil
  def destroy_session(user)
    session[:user_id] = nil
  end

  # find the current user by using the user id of the session to search user db
  def current_user
    User.find_by(id: session[:user_id])
  end

end
