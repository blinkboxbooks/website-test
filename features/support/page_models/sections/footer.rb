module PageModels
  class Footer < SitePrism::Section
    element :version_div, "div.versionInfo", visible: false

    def version_info
      version_div.text(:all)
    end
  end
end