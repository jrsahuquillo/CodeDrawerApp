class PinCodetoolsController < ApplicationController
  def index
    pinned_ids = PinCodetool.where(user: current_user).map(&:codetool_id)
    @pinned_codetools = Codetool.where(id: pinned_ids)
  end

  def create
    @pinned_codetool = PinCodetool.new(user_id: current_user.id, codetool_id: params[:codetool_id])
    respond_to do |format|
      if @pinned_codetool.save
        format.html
        format.js {render 'create', locals: {codetool_id: params[:codetool_id]}}
      else
        flash[:alert] = "Codetool has not been pinned"
      end
    end
  end

  def destroy
    @pinned_codetool = PinCodetool.where(user_id: current_user.id, codetool_id: params[:codetool_id])
    @pinned_codetool.destroy_all
    respond_to do |format|
      format.js {render 'destroy', locals: {codetool_id: params[:codetool_id]}}
    end
  end

  def clear
    PinCodetool.where(user: current_user).destroy_all
    redirect_to '/pin_codetools'
  end
end