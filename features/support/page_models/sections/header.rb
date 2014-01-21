module PageModels
  class Header < PageModels::BlinkboxbooksSection
    element :account_options_dropdown, 'ul#user-navigation-handheld'
    element :main_pages_navigation, 'div#main-navigation'
    element :user_account_logo, '#user-menu'
    element :welcome, '.username'

    def account_nav_link(link_name)
      account_options_dropdown.find("a", :text => "#{link_name}")
    end

    def navigate_to_account_option(link_name)
      wait_until_user_account_logo_visible #siteprism method
      user_account_logo.click
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