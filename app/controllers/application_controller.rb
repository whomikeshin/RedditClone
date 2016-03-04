class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :require_user_login, :require_moderator


  def current_user
    return nil unless session[:session_token]
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def require_user_login
    if current_user.nil?
      redirect_to new_session_url
    end
  end

  def require_moderator
    @sub = Sub.find(params[:id])
    unless current_user && (current_user == @sub.moderator)
      redirect_to sub_url(@sub)
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
