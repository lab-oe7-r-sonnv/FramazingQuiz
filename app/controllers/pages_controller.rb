class PagesController < ApplicationController
  before_action :load_lessons, only: [:home, :show]

  def home; end

  def show
    pages_name = request.path.split("/").last
    if valid_page? pages_name
      render "pages/#{pages_name}"
    else
      render file: "public/404.html", status: :not_found
    end
  end

  private

  def valid_page? pages_name
    File.exist?(
      Pathname.new(Rails.root + "app/views/pages/#{pages_name}.html.erb")
    )
  end

  def load_lessons
    @lessons = Lesson.all
    @list_lessons = Lesson.includes(topic: :creator).recent.take 15
  end
end
