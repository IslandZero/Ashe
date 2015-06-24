class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_locale
  before_action :authenticate_device

  def validate_useragent!
    bad = false
    if request.user_agent.to_s.include?('MicroMessenger')
      bad = true
    else
      ua = UserAgent.parse(request.user_agent)
      bad_browser = ua.browser != 'Safari'
      bad_platform= !['iPhone', 'iPad', 'iPod'].include?(ua.platform)
      bad = bad_browser || bad_platform
    end
    if bad
      render "shared/bad_ua"
    end
  end

  def authenticate_device
    return if @device_authenticated == true
    if session[:token].blank?
      session[:token] = params[:token]
    end

    unless session[:token].blank?
      @current_device = Device.find_by_token session[:token]
    end
    @device_authenticated = true
  end

  def authenticate_device!
    authenticate_device
    if @current_device.nil?
      redirect_to new_device_path, alert: 'Please register your device first !'
    end
  end

  def set_locale
    I18n.locale = http_accept_language.compatible_language_from(I18n.available_locales)
  end
end
