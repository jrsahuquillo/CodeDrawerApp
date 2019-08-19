class DrawersController < ApplicationController
  # before_action :authenticate_user!
  before_action :set_drawer, only: [:show, :edit, :update, :destroy]

  def index
    @drawers = Drawer.all
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

  def show; end

  def edit; end

  def update
    if @drawer.update(drawer_params)
      flash[:success] = "Drawer has been updated"
      redirect_to @drawer
    else
      flash.now[:danger] = "Drawer has not been updated"
      render :edit
    end
  end

  def destroy
    if @drawer.destroy
      flash[:success] = "Drawer has been deleted"
      redirect_to drawers_path
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
