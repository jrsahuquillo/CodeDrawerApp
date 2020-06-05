class DrawersController < ApplicationController
  include ApplicationHelper
  before_action :authenticate_user!
  before_action :set_drawer, only: [:show, :edit, :update, :destroy]

  def index
    if current_device_is_mobile?
      @drawers = current_user.drawers.sort_by(&:position)
      render :index
    else
      if current_user.collaborated_drawers.present? || current_user.drawers.present?
        return redirect_to drawer_codetools_path(current_user.drawers.first) if current_user.drawers.present?
        return redirect_to drawer_codetools_path(current_user.collaborated_drawers.first) if current_user.collaborated_drawers.present?
      else
        @drawers = []
      end
    end
  end

  def sort_drawer
    params[:drawer].each_with_index do |id, index|
      current_user.drawers.where(id: id).update_all( position: index + 1 )
    end
  end

  def new
    @drawer = Drawer.new
  end

  def create
    @drawer = Drawer.new(drawer_params)
    @drawer.position = 0
    @drawer.user = current_user
    if @drawer.save
      set_drawer_collaborators
      flash[:success] = "Drawer has been created"
      redirect_to drawer_codetools_path(@drawer)
    else
      flash.now[:danger] = "Drawer has not been created"
      render :new
    end
  end

  def show
    if @drawer.user != current_user
      resource_not_found
    end

    @codetool = @drawer.codetools.build
    @codetools = @drawer.codetools
  end

  def edit
    @friends = @drawer.friends
    unless @drawer.user == current_user
      flash[:alert] = "You can only edit your own drawer."
      redirect_to drawer_codetools_path(@drawer)
    end
  end

  def update
    unless @drawer.user == current_user
      flash[:danger] = "You can only edit your own drawer."
      redirect_to drawer_codetools_path(@drawer)
    else
      if @drawer.update(drawer_params)
        set_drawer_collaborators
        flash[:success] = "Drawer has been updated"
        redirect_to drawer_codetools_path(@drawer)
      else
        flash.now[:danger] = "Drawer has not been updated"
        render :edit
      end
    end
  end

  def destroy
    unless @drawer.user == current_user
      flash[:alert] = "You can only delete your own drawer."
      redirect_to drawer_codetools_path(@drawer)
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

  def drawer_collaborators_params
    params.require(:drawer).permit(friend_ids:[])
  end

  def set_drawer_collaborators
    initial_friends_ids = @drawer.friends.map(&:id).map(&:to_s)
    friends_ids = drawer_collaborators_params[:friend_ids].reject { |e| e.to_s.empty? }

    added_collaborators = initial_friends_ids + friends_ids - initial_friends_ids
    added_collaborators.each do |friend_id|
      DrawerCollaborator.create(drawer_id: @drawer.id, friend_id: friend_id)
      Notification.create(recipient: User.find(friend_id), actor: current_user, action: "added you as collaborator of", notifiable: @drawer )
    end

    removed_collaborators = initial_friends_ids - friends_ids
    removed_collaborators.each do |friend_id|
      DrawerCollaborator.where(drawer_id: @drawer.id, friend_id: friend_id).destroy_all
      Notification.create(recipient: User.find(friend_id), actor: current_user, action: "removed you as collaborator of", notifiable: @drawer )
    end
  end

end
