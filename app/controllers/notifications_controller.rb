class NotificationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_unread_notifications
  before_action :set_all_notifications
  before_action :trim_notifications

  def index
    @last_notifications = current_user.notifications.sort_by(&:created_at).reverse
  end

  def mark_as_read
    @notifications.update_all(read_at: Time.zone.now)
    render json: { success: true }
  end

  private

  def set_unread_notifications
    @notifications = current_user.notifications.unread
  end

  def set_all_notifications
    @all_notifications = current_user.notifications
  end

  def trim_notifications
    @all_notifications.sort_by(&:created_at).first.destroy if @all_notifications.count > 25
  end


end
