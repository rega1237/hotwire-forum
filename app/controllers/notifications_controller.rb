class NotificationsController < ApplicationController
  def mark_as_read
    current_user.notifications.unread.update_all(read_at: Time.zone.now)
    head :no_content
  end
end
