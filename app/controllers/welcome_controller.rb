class WelcomeController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => [:udid_callback]

  def index
  end

end
