class SubsController < ApplicationController

  before_action :require_moderator, except: [:show, :index]

  def new
    render :new
  end

  def create
    @sub = current_user.subs.new(sub_params)
    if @sub.save
      redirect_to sub_url(@sub)
    else
      redirect_to new_sub_url
    end
  end

  def show
    @sub = Sub.find(params[:id])
    render :show
  end

  def edit
    @sub = Sub.find(params[:id])
    @action = :patch
    render :edit
  end

  def update
    @sub = Sub.find(params[:id])
    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      redirect_to edit_sub_url(@sub)
    end
  end

  def index
    @subs = Sub.all
    render json: @subs
  end



  private
  def sub_params
    params.require(:sub).permit(:title, :description)
  end

end
