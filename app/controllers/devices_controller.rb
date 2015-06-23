class DevicesController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => [:create]

  def new
  end

  def create_mobileconfig
    if params[:owner].blank?
      redirect_to({ action: :new }, { alert: "Please input owner name" })
    else
      @callback_url = devices_url(owner: params[:owner])
    end
  end

  def create
    device = Device.create_from_plist(P7sPlist.parse(request.raw_post.to_s), params[:owner])
    redirect_to action: :show, id: device.id
  end

  def show
    @deivce = Device.find params[:id]
  end
end
