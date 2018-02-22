class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_locale

  rescue_from ActionController::RoutingError, with: :routes_error

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
end
