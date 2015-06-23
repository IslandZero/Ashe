class WelcomeController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => [:udid_callback]

  def index
  end

  def udid
    @callback_url = udid_callback_url
  end

  def udid_callback
    post_data = request.raw_post.to_s
  end
end
