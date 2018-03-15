class ApplicationController < ActionController::Base
  include ApplicationHelper
  protect_from_forgery with: :exception
  before_action :set_locale, :set_support_header
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from ActionController::RoutingError, with: :routes_error

  rescue_from CanCan::AccessDenied do
    redirect_with_flash(:danger, t("message.danger.access_denied"),
      main_app.root_url)
  end

  helper_method :current_user_id

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_up,
      keys: [:name, :gender, :type]
  end

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def redirect_with_flash type, msg, url
    flash[type] = msg
    redirect_to url
  end

  def routes_error
    render file: "public/404.html", status: :not_found
  end

  def find_lesson
    @lesson = Lesson.find_by id: params[:id]

    return if lesson
    routes_error
  end

  def find_user
    @user = User.find_by id: params[:id]

    return if user
    routes_error
  end

  def add_word words, word
    words << word
  end

  def remove_word words, word
    words.delete word
  end

  def set_support_header
    @header = {
      searched_users: User.search(search_params),
      searched_lessons: Lesson.search(search_params),
      notifications: feed_noti
    }
  end

  def current_user_id
    current_user ? current_user.id : Settings.users.temp_id
  end

  def search_params
    params[:q]
  end

  def feed_noti
    number = Settings.number_of_feed_noti
    current_user ? current_user.notifications.desc.take(number) : nil
  end
end
