module BuildsHelper
  def ipa_install_url(build)
    "itms-services://?action=download-manifest&url=#{build_url(build, format: :plist).html_safe}"
  end
end
