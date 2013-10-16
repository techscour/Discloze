class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :require_login, :set_user
  include ApplicationHelper

  private

   def set_user
      @user = session[:user]
      @user_id = session[:user_id]
   end

  def require_login
    unless session[:user]
      flash[:error] = "You must be logged in to access this section."
      redirect_to root_url  # halts request cycle
    end
  end
end
