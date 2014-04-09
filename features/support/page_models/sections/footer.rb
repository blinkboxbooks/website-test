module PageModels
  class Footer < PageModels::BlinkboxbooksSection
    element :version_div, "div.versionInfo", visible: false
    elements :top_authors, "div#footer_authors1 ul.lists li"
    elements :top_categories, "div#footer_categories ul.lists li"

    def version_info
      version_div.text(:all)
    end
  end
end