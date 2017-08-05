class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery prepend: true
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :set_locale

  def set_locale
    I18n.locale = (params.permit(:lang)[:lang] || extract_locale_from_accept_language_header || Rails.application.config.i18n.default_locale || 'en')
    I18n.locale = :en
  end

  def extract_locale_from_accept_language_header
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end

end
