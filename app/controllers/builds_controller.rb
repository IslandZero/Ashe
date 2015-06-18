require 'uri'

require 'zip'
require 'cfpropertylist'

class BuildsController < ApplicationController

  def new
  end

  def create
    form_params = params.require(:build).permit(:file, :desc)
    file = form_params[:file]
    desc = form_params[:desc]

    if file
      Zip::File.open(file.path) do |zip_file|
        plist_entry = zip_file.glob("**/*.app/Info.plist").first
        if plist_entry
          plist = CFPropertyList::List.new({ data: plist_entry.get_input_stream.read.to_s,
                                             format: CFPropertyList::List::FORMAT_BINARY })
          @build = Build.create_from_plist CFPropertyList.native_types plist.value
          @build.file = file
          @build.desc = desc
          @build.save
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
  end
end
