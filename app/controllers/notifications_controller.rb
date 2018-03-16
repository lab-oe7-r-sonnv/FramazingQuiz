class NotificationsController < ApplicationController
  attr_reader :user

  before_action :authenticate_user!
  before_action :find_user

  def index
    @all_notifications = user.notifications.desc.paginate page: params[:page]
  end
end
