class ApplicationController < ActionController::Base
  # rescue_from Mysql2::Error::ConnectionError, with: :db_connection_error
  around_action :switch_locale

  def switch_locale(&action)
    locale = params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end

  def default_url_options
    { locale: I18n.locale }
  end

  private
  # def db_connection_error
    # render :status => 500
  # end
end
