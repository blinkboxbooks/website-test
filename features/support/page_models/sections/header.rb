module PageModels
  class Header < PageModels::BlinkboxbooksSection
    element :account_options_dropdown, 'ul#user-navigation-handheld'
    element :main_pages_navigation, 'div#main-navigation'
    element :user_account_logo, '#user-menu'
    element :main_menu, '#main-menu'
    element :main_menu_option_dropdown, 'ul#main-navigation-handheld'
    element :welcome, '.username'
    element :search_input, '[data-test="search-input"]'
    element :search_button, '[data-test="search-button"]'

    def account_nav_link(menu, link_name)
      menu.find("a", :text => "#{link_name}")
    end

    def navigate_to_account_option(link_name)
      wait_until_user_account_logo_visible #siteprism method
      user_account_logo.click
      account_options_dropdown.should be_visible
      account_nav_link(account_options_dropdown, link_name).click
    end

    def main_page_navigation(page_name)
      within(main_pages_navigation) do
        click_link page_name
      end
    end

    def navigate_to_main_menu_option(sub_menu, link_name)
      wait_until_main_menu_visible
      main_menu.click
      main_menu_option_dropdown.should be_visible
      account_nav_link(main_menu_option_dropdown, sub_menu).click
      account_nav_link(main_menu_option_dropdown, link_name).click
    end
  end
end
