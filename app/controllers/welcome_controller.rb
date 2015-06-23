class WelcomeController < ApplicationController
  def index
  end

  def delete_devices
    Device.delete_all

    render plain: "All Device Data Purged"
  end
end
