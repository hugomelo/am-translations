class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!

  before_filter :set_locale
  def set_locale
    I18n.locale = (params[:lang] || extract_locale_from_accept_language_header || Rails.application.config.i18n.default_locale || 'en')
  end
  def extract_locale_from_accept_language_header
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
  end

end
