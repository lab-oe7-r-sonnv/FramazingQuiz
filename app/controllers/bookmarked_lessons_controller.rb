class BookmarkedLessonsController < ApplicationController
  attr_reader :user, :lesson

  before_action :authenticate_user!
  before_action :find_user, only: :index
  before_action :find_lesson, only: %i(create destroy)

  def index
    @bookmarked_lessons = user.bookmarked_lessons.paginate page: params[:page]
    render :index, locals: {title: t(".title", user: user.name)}
  end

  def create
    lesson.update_attributes bookmarker_id: current_user.id
    redirect_with_flash :success, t(".bookmarked"), request.referer
  end

  def destroy
    lesson.update_attributes bookmarker_id: nil
    redirect_with_flash :success, t(".unbookmarked"), request.referer
  end
end
