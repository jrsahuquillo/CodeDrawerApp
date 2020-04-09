
class FavoriteCodetoolsController < ApplicationController

  def index
    @favorite_codetools = FavoriteCodetool.where(user_id: current_user.id)
                                          .map{|favorite| favorite.codetool}
                                          .sort_by(&:total_favorites).reverse
  end

  def create
    codetool_id = params[:codetool_id]
    unless codetool_already_favorited?
      @favorite_codetool = FavoriteCodetool.new(user_id: current_user.id, codetool_id: codetool_id)
      if @favorite_codetool.save
        Notification.create(recipient: @favorite_codetool.codetool.user, actor: current_user, action: "favorited", notifiable: @favorite_codetool )
      else
        flash[:alert] = "Codetool has not been favorited"
      end
    end
  end

  def codetool_already_favorited?
    favorite_codetool.present?
  end

  def destroy
    favorite_codetool.destroy
  end

  def self.destroy_favorites(codetool)
    FavoriteCodetool.where(codetool_id: codetool_id).destroy_all
  end


  private

  def favorite_codetool
    FavoriteCodetool.find_by(user_id: current_user.id, codetool_id: params[:codetool_id])
  end

end
