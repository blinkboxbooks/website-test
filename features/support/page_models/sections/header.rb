module PageModels
  class Header < PageModels::BlinkboxbooksSection
    element :account_options_dropdown, 'ul#user-navigation-handheld'
    element :main_pages_navigation, 'div#main-navigation'
    element :account_logo, '.float-right'

    def account_nav_link(link_name)
      account_options_dropdown.find("a", :text => "#{link_name}")
    end

    def navigate_to_account_option(link_name)
      page.find('#outer-header').should be_visible
      account_logo.should be_visible
      account_logo.click
      account_options_dropdown.should be_visible
      account_nav_link(link_name).click
    end

    def main_page_navigation(page_name)
      within(main_pages_navigation) do
        click_link page_name
      end
    end
  end
end