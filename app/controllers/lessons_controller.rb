class LessonsController < ApplicationController
  attr_reader :lesson, :searched_lessons

  before_action :find_lesson, only: %i(show edit update destroy)
  before_action :correct_user, only: %i(edit update destroy)
  before_action :authorize_lesson, except: %i(index show)
  before_action :search_lesson, only: %i(index)

  def index
    user = User.find_by id: params[:id]
    title = t(".title", user: user.name)

    if user
      lessons = user.lessons.paginate page: params[:page]
      render "users/_show_lessons", locals: {title: title, user: user, lessons:
        lessons}
    else
      redirect_with_flash :danger, t("message.danger.user_not_found"), root_url
    end
  end

  def show; end

  def new
    @lesson = Lesson.new
    2.times do
      word = lesson.lesson_words.build.build_word
      word.definitions.build
    end
  end

  def create
    @lesson = current_user.lessons.new lesson_params

    if lesson.save
      redirect_with_flash :success, t("message.success.lesson_created"), lesson
    else
      render :new
    end
  end

  def edit; end

  def update
    if lesson.update lesson_params
      redirect_with_flash :success, t("message.success.lesson_updated"), lesson
    else
      render :edit
    end
  end

  def destroy
    lesson.destroy
    redirect_with_flash :success, t("message.success.lesson_deleted"),
      lessons_user_url(current_user)
  end

  private

  def search_lesson
    return unless params[:q]
    @search_support = SearchSupports.new searched_lessons
    @lessons = searched_lessons.result.paginate page: params[:page]
    render :index
  end

  def lesson_params
    params.require(:lesson).permit :id, :name, :picture, :blocked,
      lesson_words_attributes: [:id, :lesson_id, :word_id, :_destroy,
      word_attributes: [:id, :text,
      definitions_attributes: [:id, :text, :correct]]]
  end

  def find_lesson
    @lesson = Lesson.find_by id: params[:id]

    return if lesson
    redirect_with_flash :danger, t("message.danger.lesson_not_found"), root_url
  end

  def correct_user
    return if current_user.current_user? lesson.user
    redirect_with_flash :danger, t("message.danger.access_denied"), root_url
  end

  def authorize_lesson
    authorize! :manage, Lesson
  end
end
