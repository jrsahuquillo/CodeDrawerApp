
class CodetoolsController < ApplicationController
  before_action :set_drawer
  before_action :set_codetool, only: [:edit, :update, :destroy]

  def index
    @codetools = Codetool.all
  end

  def new
    @codetool = Codetool.new
  end

  def create
    @codetool = @drawer.codetools.build(codetool_params)
    @codetool.user = current_user

    if @codetool.save
      flash[:notice] = "Codetool has been created"
    else
      flash[:alert] = "Codetool hast not been created"
    end
    redirect_to drawer_codetools_path(@drawer)
  end

  def edit
    unless @codetool.user == current_user
      flash[:alert] = "You can only edit your own codetool."
      redirect_to drawer_codetools_path(@drawer)
    end
  end

  def update
    unless @codetool.user == current_user
      flash[:danger] = "You can only edit your own codetool."
      redirect_to drawer_codetools_path(@drawer)
    else
      if @codetool.update(codetool_params)
        flash[:success] = "Codetool has been updated"
        redirect_to drawer_codetools_path(@drawer)
      else
        flash.now[:danger] = "Codetool has not been updated"
        render :edit
      end
    end
  end

  def destroy
    unless @codetool.user == current_user
      flash[:alert] = "You can only delete your own codetool."
      redirect_to drawer_codetools_path(@drawer)
    else
      if @codetool.destroy
        flash[:success] = "Codetool has been deleted"
        redirect_to drawer_codetools_path(@drawer)
      end
    end
  end

  private

  def codetool_params
    params.require(:codetool).permit(:title, :content)
  end

  def set_drawer
    @drawer = Drawer.find(params[:drawer_id])
  end

  def set_codetool
    @codetool = Codetool.find(params[:id])
  end
end
