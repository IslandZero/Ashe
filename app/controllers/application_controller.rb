class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_device

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
      redirect_to new_device_path
    end
  end
end
