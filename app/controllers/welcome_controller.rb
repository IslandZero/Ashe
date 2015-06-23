class WelcomeController < ApplicationController
  def index
  end

  def udid
    @callback_url = udid_callback_url
  end

  def udid_callback
  end
end
