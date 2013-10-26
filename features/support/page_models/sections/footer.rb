module PageModels
  class Footer < PageModels::BlinkboxbooksSection
    element :version_div, "div.versionInfo", visible: false

    def version_info
      version_div.text(:all)
    end
  end
end