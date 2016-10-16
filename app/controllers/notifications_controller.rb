class NotificationsController < ApplicationController
  def link_through
    @notification = Notification.find(params[:id])
    @notication.update read: true
    redirect_to post_path(@notification.post)
  end

  def index
    @notifications = current_user.notifications
  end
end
