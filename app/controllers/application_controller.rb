class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_locale
  before_action :authenticate_device
  before_action :authenticate_admin

  def validate_useragent!
    # Skip UA validation if not html
    return if request.format != 'text/html'
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

  def authenticate_admin
    return if @admin_authenticated == true
    @is_admin = (session[:is_admin].to_s == 'Y') || ENV['ADMIN_TOKEN'].blank?
    @admin_authenticated = true
  end

  def authenticate_admin!
    authenticate_admin
    unless @is_admin
      redirect_to root_path, alert: t('ashe.no_permission')
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
      redirect_to new_device_path, alert: t('ashe.please_register_device')
    end
  end

  def set_locale
    I18n.locale = http_accept_language.compatible_language_from(I18n.available_locales)
  end
end
