class DrawersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_drawer, only: [:show, :edit, :update, :destroy]

  def index
    @drawers = current_user.drawers
  end

  def new
    @drawer = Drawer.new
  end

  def create
    @drawer = Drawer.new(drawer_params)
    @drawer.user = current_user
    if @drawer.save
      flash[:success] = "Drawer has been created"
      redirect_to drawers_path
    else
      flash.now[:danger] = "Drawer has not been created"
      render :new
    end
  end

  def show
    if @drawer.user != current_user
      resource_not_found
    end
  end

  def edit
    unless @drawer.user == current_user
      flash[:alert] = "You can only edit your own drawer."
      redirect_to root_path
    end
  end

  def update
    unless @drawer.user == current_user
      flash[:danger] = "You can only edit your own drawer."
      redirect_to root_path
    else
      if @drawer.update(drawer_params)
        flash[:success] = "Drawer has been updated"
        redirect_to @drawer
      else
        flash.now[:danger] = "Drawer has not been updated"
        render :edit
      end
    end
  end

  def destroy
    unless @drawer.user == current_user
      flash[:alert] = "You can only delete your own drawer."
      redirect_to root_path
    else
      if @drawer.destroy
        flash[:success] = "Drawer has been deleted"
        redirect_to drawers_path
      end
    end
  end

  protected
    def resource_not_found
      message = "The drawer you are looking for could not be found"
      flash[:warning] = message
      redirect_to root_path
    end
  private

  def set_drawer
    @drawer = Drawer.find(params[:id])
  end

  def drawer_params
    params.require(:drawer).permit(:title, :description)
  end
end
