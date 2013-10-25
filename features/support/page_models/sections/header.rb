module PageModels
  class Header < PageModels::BlinkboxbooksSection
    element :account_options_dropdown, "ul#user-navigation-handheld"

    def account_nav_link(link_name)
      title = link_name.gsub("&", "&amp;")
      account_options_dropdown.find("a[title=\"#{title}\"]")
    end

    def navigate_to_account_option(link_name)
      self.should have_account_options_dropdown
      account_options_dropdown.click
      account_nav_link(link_name).click
    end
  end
end