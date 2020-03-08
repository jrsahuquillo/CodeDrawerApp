class NotificationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_notifications

  def index
  end

  def mark_as_read
    @notifications.update_all(read_at: Time.zone.now)
    render json: { success: true }
  end

  private

  def set_notifications
    @notifications = current_user.notifications.unread
  end

end
