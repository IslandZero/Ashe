require 'uri'

require 'zip'
require 'cfpropertylist'

class BuildsController < ApplicationController
  before_action :validate_useragent!,   only: [:show]
  before_action :authenticate_device!,  only: [:show]
  before_action :authenticate_admin!,   only: [:new, :create]

  def new
  end

  def create
    form_params = params.require(:build).permit(:file, :desc)
    file = form_params[:file]
    desc = form_params[:desc]

    if file
      # Open zip file
      Zip::File.open(file.path) do |zip_file|
        # Get Info.plist and create build
        plist_entry = zip_file.glob("**/*.app/Info.plist").first
        if plist_entry
          plist = CFPropertyList::List.new({ data: plist_entry.get_input_stream.read.to_s,
                                             format: CFPropertyList::List::FORMAT_BINARY })
          @build = Build.create_from_plist CFPropertyList.native_types plist.value
          @build.file = file
          @build.desc = desc
          @build.save
        end
        # Get embedded.mobileprovision and record provisioned devices
        if @build
          provi_entry = zip_file.glob("**/*.app/embedded.mobileprovision").first
          if provi_entry
            provi = P7sPlist.parse provi_entry.get_input_stream.read.to_s
            if provi 
              devices = provi['ProvisionedDevices']
              if devices.kind_of? Array
                devices.each do |device_udid|
                  @build.provisions.create(udid: device_udid)
                end
              end
            end
          end
        end
      end
    end

    if !@build
      redirect_to new_build_path, alert: 'Cannot create this build'
    else
      redirect_to action: :show, id: @build.id
    end
  end

  def show
    @build = Build.find(params[:id])
    @build_file_url = URI.join(request.url, @build.file_url).to_s
    @can_install = Provision.find_by(build_id: @build.id, udid: @current_device.udid).present?
  end
end
