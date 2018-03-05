class ApplicationController < ActionController::Base
  include ApplicationHelper
  protect_from_forgery with: :exception
  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from ActionController::RoutingError, with: :routes_error

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

  def add_word words, word
    words << word
  end

  def remove_word words, word
    words.delete word
  end
end
