require 'cfpropertylist'

class P7sPlist
  PLIST_START = '<?xml version="'
  PLIST_END   = '</plist>'
  def self.parse(str)
    str = str.to_s
    xstart = str.index PLIST_START
    xend   = str.index PLIST_END
    if xstart != nil and xend != nil
      plist_s = str[xstart, xend + PLIST_END.length]
      CFPropertyList.native_types CFPropertyList::List.new({ data: plist_s })
    else
      nil
    end
  end
end
