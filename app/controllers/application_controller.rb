class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private

  # redirect un-signed-in users
  def require_sign_in
    unless current_user
      flash[:alert] = "You must be logged in to do that"
      # redirect un-signed-in user to new_session_path
      redirect_to new_session_path
    end
  end
end
