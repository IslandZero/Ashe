class DevicesController < ApplicationController
  def new
    @callback_url = devices_url(owner: params[:owner])
  end

  def create
    @device = Device.create_from_plist(P7sPlist.parse(request.raw_post.to_s), params[:owner])
  end
end
