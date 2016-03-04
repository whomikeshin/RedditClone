class SessionsController < ApplicationController
  def new
    @user = User.new
    render :login
  end

  def create
    @user = User.find_by_credentials(user_params[:username], user_params[:password])
    if @user.nil?
      render :login
    else
      @user.reset_session_token!
      session[:session_token] = @user.session_token
      redirect_to user_url(@user)
    end
  end

  def destroy
    session[:session_token] = nil
    redirect_to new_session_url
  end

end
