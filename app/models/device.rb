require 'securerandom'

class Device < ActiveRecord::Base
  def self.create_from_plist(plist, owner = nil)
    # Find or create
    created = false
    device = self.find_or_create_by(udid: plist['UDID']) do |d|
      d.token = SecureRandom.urlsafe_base64(32)
      created = true
    end
    # Update device info
    device.update({
      version: plist['VERSION'],
      serial:  plist['SERIAL'],
      product: plist['PRODUCT'],
      owner:   owner
    })
    # Regenerate token if not first time
    unless created
      device.update(token: SecureRandom.urlsafe_base64(32))
    end
    device
  end
end
