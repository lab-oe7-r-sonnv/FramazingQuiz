class NotificationsController < ApplicationController
  attr_reader :notification, :user

  before_action :authenticate_user!
  before_action :find_user, only: :index

  def index
    @all_notifications = user.notifications.desc.paginate page: params[:page]
  end

  def create
    @notification = Notification.new notification_params

    return unless notification.save
    notification.broadcast_bookmark
    redirect_with_flash :success, t(".bookmarked"), request.referer
  end

  private

  def notification_params
    params.require(:notification).permit :event, :user_id,
      :bookmarker_id, :lesson_id
  end
end
