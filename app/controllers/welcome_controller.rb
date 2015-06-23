class WelcomeController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => [:udid_callback]

  def index
  end

  def udid
    @callback_url = udid_callback_url
  end

  def udid_callback
  end
end
