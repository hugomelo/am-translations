class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_locale
  def set_locale
    I18n.locale = (params[:lang] || session[:lang] || Rails.application.config.i18n.default_locale || request.env['HTTP_ACCEPT_LANGUAGE'] || 'en')
    if params[:lang]
      session[:lang] = params[:lang]
    end
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
