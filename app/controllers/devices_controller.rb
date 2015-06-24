require 'securerandom'

class DevicesController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => [:create]

  before_action :validate_useragent,    only: [:new]
  before_action :authenticate_device!,  only: [:show]

  def new
    if @current_device
      redirect_to device_path(@current_device)
    end
  end

  def create_mobileconfig
    if params[:owner].blank?
      redirect_to new_device_path, { alert: "Please input owner name" }
    else
      @callback_url = devices_url(owner: params[:owner])
    end
  end

  def create
    device = Device.create_from_plist(P7sPlist.parse(request.raw_post.to_s), params[:owner])
    redirect_to device_path(device, token: device.token), status: 301
  end

  def show
    @device = Device.find params[:id]
    if @device.id != @current_device.id
      redirect_to root_path, alert: 'No permission !'
    end
  end
end
