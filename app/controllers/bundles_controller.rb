class BundlesController < ApplicationController
  def show
    @bundle = Bundle.find(params[:id])
  end
end
