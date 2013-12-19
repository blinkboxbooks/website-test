module PageModels
  class Header < PageModels::BlinkboxbooksSection
    element :account_options_dropdown, "ul#user-navigation-handheld"
    element :main_pages_navigation, "div#main-navigation"

    def account_nav_link(link_name)
      #title = link_name.gsub("&", "&amp;")
      #account_options_dropdown.find("a[title=\"#{title}\"]")
      account_options_dropdown.find("a", :text => "#{link_name}")
    end

    def navigate_to_account_option(link_name)
      self.should have_account_options_dropdown
      account_options_dropdown.click
      account_nav_link(link_name).click
      #click_link(link_name)
    end

    def main_page_navigation(page_name)
      within(main_pages_navigation) do
        click_link page_name
      end
    end
  end
end