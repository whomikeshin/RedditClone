class UsersController < ApplicationController

  before_action :require_user_login, except: [:new, :create]
  #skip_before_action :require_user_login, only: [:new, :create]

  def new
    # @user = User.new
    render :signup
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_url(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      redirect_to new_user_url
    end
  end

  def show
    @user = User.find(params[:id])
    if @user == current_user
      render :show
    else
      fail
      redirect_to subs_url
    end
  end

end
