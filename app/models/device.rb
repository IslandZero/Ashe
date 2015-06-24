require 'securerandom'

class Device < ActiveRecord::Base
  def self.create_from_plist(plist, owner = nil)
    device = self.find_or_create_by(udid: plist['UDID'])
    device.update({
      version: plist['VERSION'],
      serial:  plist['SERIAL'],
      product: plist['PRODUCT'],
      owner:   owner,
      token:   SecureRandom.urlsafe_base64(32)
    })
    device
  end
end
