class Device < ActiveRecord::Base
  def self.create_from_plist(plist, owner = nil)
    d = self.find_or_create_by(udid: plist['UDID'])
    d.update({
      version: plist['VERSION'],
      serial:  plist['SERIAL'],
      product: plist['PRODUCT'],
      owner:   owner
    })
    d
  end
end
