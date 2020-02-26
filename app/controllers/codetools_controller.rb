
class CodetoolsController < ApplicationController
  before_action :authenticate_user!, :search
  before_action :set_drawer, except: [:search]
  before_action :set_drawers
  before_action :set_codetool, only: [:edit, :update, :destroy]

  def index
    # if @drawer.friends.exclude?(current_user) || @drawer.user != current_user
    if  @drawer.user != current_user && @drawer.friends.exclude?(current_user)
      return resource_not_found
    end
    @codetools = @drawer.codetools.order(position: :asc) if @drawer.user == current_user
    @codetools = @drawer.codetools if @drawer.friends.include?(current_user)
  end

  def sort_codetool
    params[:codetool].each_with_index do |id, index|
      @drawer.codetools.where(id: id).update_all(position: index + 1 )
    end
  end

  def search
    searched_user_codetools = params[:search].blank? ? [] : current_user.codetools.search(params[:search])
    searched_friends_public_codetools = []
    current_user.friends.each do |friend|
      searched_friends_public_codetools << friend.codetools.search(params[:search])
    end
    @searched_codetools = searched_user_codetools + searched_friends_public_codetools.flatten
  end

  def new
    @codetool = Codetool.new
  end

  def create
    @codetool = @drawer.codetools.build(codetool_params)
    @codetool.position = 0
    @codetool.user = current_user

    if @codetool.save
      flash[:notice] = "Codetool has been created"
    else
      flash[:alert] = "Codetool hast not been created"
    end
    redirect_to drawer_codetools_path(@drawer)
  end

  def edit
    unless @codetool.user == current_user || @codetool.drawer.friends.include?(current_user)
      flash[:alert] = "You can only edit your own codetool."
      redirect_to drawer_codetools_path(@drawer)
    end
  end

  def update
    unless @codetool.user == current_user || @codetool.drawer.friends.include?(current_user)
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

  protected

  def resource_not_found
    message = "The drawer you are looking for could not be found"
    flash[:warning] = message
    redirect_to root_path
  end

  private

  def codetool_params
    params.require(:codetool).permit(:title, :content, :public, :position)
  end

  def set_drawer
    @drawer = Drawer.find(params[:drawer_id])
  end

  def set_drawers
    @drawers = current_user.drawers.sort_by(&:position)
  end

  def set_codetool
    @codetool = Codetool.find(params[:id])
  end
end
