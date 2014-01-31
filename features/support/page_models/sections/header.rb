module PageModels
  class Header < PageModels::BlinkboxbooksSection
    element :account_options_dropdown, 'ul#user-navigation-handheld'
    element :main_pages_navigation, 'div#main-navigation'
    element :user_account_logo, '#user-menu'
    element :main_menu, '#main-menu'
    element :main_menu_option_dropdown, 'ul#main-navigation-handheld'
    element :welcome, '.username'
    element :faqs, '[href="https://support.blinkboxbooks.com/home"]'
    element :contact_us, '[href="https://support.blinkboxbooks.com/anonymous_requests/new"]'

    def account_nav_link(menu,link_name)
      menu.find("a", :text => "#{link_name}")
    end

    def navigate_to_account_option(link_name)
      wait_until_user_account_logo_visible #siteprism method
      user_account_logo.click
      account_options_dropdown.should be_visible
      account_nav_link(account_options_dropdown,link_name).click
    end

    def main_page_navigation(page_name)
      within(main_pages_navigation) do
        click_link page_name
      end
    end

    def navigate_to_main_menu_option(sub_menu,link_name)
      wait_until_main_menu_visible
      main_menu.click
      main_menu_option_dropdown.should be_visible
      account_nav_link(main_menu_option_dropdown,sub_menu).click
      if sub_menu.include?('Support')
        click_support_link(link_name)
      else
        account_nav_link(main_menu_option_dropdown,link_name).click
      end
    end

    def click_support_link(link_name)
      if link_name.include?('Contact')
        contact_us.click
      else
        faqs.click
      end
    end
  end
end