class Build < ActiveRecord::Base
  mount_uploader :file, FileUploader
  belongs_to :bundle,     inverse_of: :builds
  has_many   :provisions, inverse_of: :build

  def self.create_from_plist(plist)
    bundle_id = plist['CFBundleIdentifier']
    version   = plist['CFBundleShortVersionString']
    build_num = plist['CFBundleVersion']
    name      = plist['CFBundleName']

    bundle = Bundle.find_or_create_by(identifier: bundle_id) do |b|
      b.name = name
    end

    self.create(version: version, build: build_num, bundle: bundle)
  end
end
