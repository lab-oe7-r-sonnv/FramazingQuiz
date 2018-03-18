class BookmarkedLessonsController < ApplicationController
  attr_reader :user, :lesson, :notification

  before_action :authenticate_user!
  before_action :find_user, only: :index
  before_action :find_lesson, only: %i(create destroy)

  def index
    @bookmarked_lessons = user.bookmarked_lessons.paginate page: params[:page]
    render :index, locals: {title: t(".title", user: user.name)}
  end

  def create
    lesson.update_attributes bookmarker_id: current_user.id
    @notification = Notification.new notification_params

    return unless notification.save
    notification.broadcast :bookmark
    redirect_with_flash :success, t(".bookmarked"), request.referer
  end

  def destroy
    lesson.update_attributes bookmarker_id: nil
    redirect_with_flash :success, t(".unbookmarked"), request.referer
  end

  private

  def notification_params
    params.require(:notification).permit :event, :user_id,
      :notifier_id, :lesson_id
  end
end
