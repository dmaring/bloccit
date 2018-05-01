class SessionsController < ApplicationController
  def new
  end

  def create
    # find user by the email in the session params
    user = User.find_by(email: params[:session][:email].downcase)
    # verify user is not nil, check that password in params hash matches the specified password
    if user && user.authenticate(params[:session][:password])
      create_session(user)
      flash[:notice] = "Welcome, #{user.name}!"
      redirect_to root_path
    # if authentication is not successful, flash warning and render new view
    else
      flash.now[:alert] = 'Invalid email/password combination'
      render :new
    end
  end

  def destroy
    destroy_session(current_user)
    flash[:notice] = "You've been signed out, come back soon!"
    redirect_to root_path
  end
end
