class LessonsController < ApplicationController
  attr_reader :lesson

  before_action :find_lesson, only: %i(show edit update destroy)
  before_action :correct_creator, only: %i(edit update destroy)

  def index
    title = t ".title"
    user = User.find_by id: params[:id]

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
    @lesson = Topic.first.lessons.build lesson_params

    if lesson.save
      redirect_with_flash :success, t("message.success.lesson_created"), lesson
    else
      render :new
    end
  end

  def edit; end

  def update
    if lesson.update_attributes lesson_params
      redirect_with_flash :success, t("message.success.lesson_updated"), lesson
    else
      render :edit
    end
  end

  def destroy
    lesson.destroy
    redirect_with_flash :success, t("message.success.lesson_deleted"),
      lessons_user_url(User.first)
  end

  private

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

  def correct_creator; end
end
