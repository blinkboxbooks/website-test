module PageModels
  class AccountMenu < PageModels::BlinkboxbooksSection
    element :sign_out_button, 'a[data-test="menu-sign-out-button"]'
    element :sign_in_button, 'a[data-test="menu-sign-in-button"]'
    element :menu_register_link, '[data-test="menu-register-link"]'
  end

  class Header < PageModels::BlinkboxbooksSection
    element :main_pages_navigation, 'div#main-navigation'
    element :user_account_logo, '#user-menu'
    element :main_menu, '#main-menu'
    element :welcome, '.username'
    element :search_input, '[data-test="search-input"]'
    element :search_button, '[data-test="search-button"]'
    element :suggestions, 'ul#suggestions'
    element :logo, "#logo a"

    section :account_menu, AccountMenu, 'ul#user-navigation-handheld'
    element :hamburger_menu, 'ul#main-navigation-handheld'

    def open_account_menu
      wait_until_user_account_logo_visible
      user_account_logo.click
      expect(account_menu).to be_visible
    end  

    def navigate_to_account_option(link_name)
      open_account_menu

      # Transform account option to a data-attribute.
      account_menu.find('[data-test="' +  link_name.downcase.gsub(/ /, '-') + '"]').click
    end

    def click_log_out
      open_account_menu
      account_menu.sign_out_button.click
    end

    def main_page_navigation(page_name)
      within(main_pages_navigation) do
        click_link page_name
      end
    end

    def navigate_to_hamburger_menu_option(link_name)
      wait_for_main_menu
      main_menu.click
      expect(hamburger_menu).to be_visible
      hamburger_menu.find("a", :text => "#{link_name}").click
    end
  end
end
