class AdminController < ApplicationController

  def index
  end

  def enable
    if params[:admin_token].to_s == ENV['ADMIN_TOKEN'].to_s
      session[:is_admin] = 'Y'
      redirect_to root_path
    else
      redirect_to admin_path, alert: 'Admin token mismatch'
    end
  end

  def disable
    session[:is_admin] = nil
    redirect_to root_path
  end

end
