
class CodetoolsController < ApplicationController

  before_action :authenticate_user!, :search, except: [:show]
  before_action :set_drawer, except: [:search]
  before_action :set_drawers, except: [:show]
  before_action :set_codetool, only: [:show, :edit, :update, :destroy]

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
    @searched_user_codetools = params[:search].blank? ? [] : current_user.codetools.search(params[:search])
    @searched_friends_public_codetools = []
    current_user.friends.each do |friend|
      @searched_friends_public_codetools << friend.codetools.is_public.search(params[:search])
    end
    @searched_friends_public_codetools = @searched_friends_public_codetools.flatten
  end

  def new
    @codetool = Codetool.new
  end

  def create
    @codetool = @drawer.codetools.build(codetool_params)
    @codetool.position = 0
    @codetool.user = current_user
    if @codetool.save
      flash[:success] = "Codetool has been created"
      if params[:commit] == "Quick save"
        render 'edit'
      else
        redirect_to drawer_codetools_path(@drawer, show: @codetool.to_param)
      end
    else
      flash[:alert] = "Codetool has not been created"
      render :new
    end
  end

  def show
  end

  def edit
    unless @codetool.user == current_user || @codetool.drawer.friends.include?(current_user)
      flash[:alert] = "You can only edit your own codetool."
      redirect_to drawer_codetools_path(@drawer)
    end
  end

  def update
    if @codetool.user != current_user || !@codetool.drawer.friends.include?(current_user)
      drawer_id = params[:codetool][:drawer_id] || @drawer.id
      if user_can_select_drawer?(drawer_id.to_i) &&
        @codetool.update(codetool_params)
        flash[:success] = "Codetool has been updated"
        if params[:commit] == "Quick save"
          render 'edit'
        else
          redirect_to drawer_codetools_path(@drawer, show: @codetool.to_param)
        end
      else
        flash.now[:danger] = "Codetool has not been updated"
        render :edit
      end
    else
      flash[:danger] = "You can only edit your own codetool."
      redirect_to drawer_codetools_path(@drawer)
    end
  end

  def destroy
    unless @codetool.user == current_user
      flash[:alert] = "You can only delete your own codetool."
      redirect_to drawer_codetools_path(@drawer)
    else
      if @codetool.destroy
        FavoriteCodetool.where(codetool_id: @codetool.id).destroy_all
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
    params.require(:codetool).permit(:drawer_id, :title, :content, :public, :position)
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

  def user_can_select_drawer?(drawer_id)
    (current_user.drawers + current_user.collaborated_drawers).map(&:id).include?(drawer_id)
  end
end
