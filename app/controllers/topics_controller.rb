class TopicsController < ApplicationController
  attr_reader :topics, :topic, :user, :lesson, :title

  before_action :authenticate_user!, except: %i(index show)
  before_action :find_user
  before_action :correct_user, except: %i(index show)
  before_action :find_topic, except: %i(index new create)
  before_action :assign_title, except: %i(new create)
  before_action :find_lesson, only: :update

  def index
    @topics = user.topics.paginate page: params[:page]
    render :index, locals: {title: title, topics: topics}
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = current_user.topics.build topic_params

    return render :new unless topic.save
    redirect_with_flash :success, t(".topic_created"), topics_path(current_user)
  end

  def show; end

  def edit; end

  def update
    add_lesson_to_topic topic.id
  end

  def destroy
    if params[:topic]
      find_lesson
      add_lesson_to_topic nil
    else
      topic.destroy
      redirect_with_flash :success, t("message.success.topic_deleted"),
        topics_path(current_user)
    end
  end

  private

  def topic_params
    params.require(:topic).permit :name, :blocked, :picture, :creator_id,
      lessons_attributes: [:id, :topic_id]
  end

  def find_topic
    @topic = Topic.find_by id: params[:topic_id]

    return routes_error unless topic
  end

  def find_lesson
    @lesson = Lesson.find_by id: params[:topic][:lesson_id]

    return routes_error unless lesson
  end

  def assign_title
    @title = t ".title", user: user.name
  end

  def add_lesson_to_topic id
    lesson.update_attributes topic_id: id
    redirect_to edit_topic_path
  end

  def correct_user
    return if user == current_user
    redirect_with_flash :danger, t("message.danger.access_denied"), root_url
  end
end
