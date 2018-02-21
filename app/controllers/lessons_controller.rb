class LessonsController < ApplicationController
  attr_reader :lesson

  def index
    title = t ".title"
    user = User.find_by id: params[:id]
    return redirect_to "root_url" unless user
    lessons = user.lessons.paginate page: params[:page]
    render "users/_show_lessons", locals: {title: title, user: user, lessons:
      lessons}
  end

  def new
    @lesson = Lesson.new
    2.times do
      word = lesson.lesson_words.build.build_word
      word.definitions.build
    end
  end

  def create
    @lesson = Topic.first.build lesson_params

    if lesson.save
      redirect_to lesson
    else
      render :new
    end
  end

  def edit; end

  private

  def lesson_params
    params.require(:lesson).permit :name, :picture, :blocked,
      lesson_words_attributes: [:lesson_id, :word_id, :_destroy,
      word_attributes: [:text, definitions_attributes: [:text, :correct]]]
  end
end
