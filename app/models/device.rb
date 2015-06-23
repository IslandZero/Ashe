class Device < ActiveRecord::Base
  def self.create_from_plist(plist, owner = nil)
    self.find_or_create_by(udid: plist['UDID']) do |d|
      d.version = plist['VERSION']
      d.serial  = plist['SERIAL']
      d.product = plist['PRODUCT']
      d.owner   = owner
    end
  end
end
