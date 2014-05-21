module PageModels
  class AccountMenu < PageModels::BlinkboxbooksSection
    element :sign_out_button, 'a[data-test="menu-sign-out-button"]'
    element :sign_in_button, 'a[data-test="menu-sign-in-button"]'
    element :menu_register_link, '[data-test="menu-register-link"]'
  end

  class HeaderLinks < PageModels::BlinkboxbooksSection
    element :featured, '[data-test="header-featured"]'
    element :categories, '[data-test="header-categories-link"]'
    element :bestsellers, '[data-test="header-bestsellers-link"]'
    element :new_releases, '[data-test="header-new-releases-link"]'
    element :free_ebooks, '[data-test="header-top-free-link"]'
    element :authors, '[data-test="header-authors-link"]'
  end

  class Header < PageModels::BlinkboxbooksSection
    element :main_pages_navigation, 'div#main-navigation'
    element :user_account_logo, '#user-menu'
    element :main_menu, '#main-menu'
    element :welcome, '.username'
    element :search_input, '[data-test="search-input"]'
    element :search_button, '[data-test="search-button"]'
    element :suggestions, 'ul#suggestions'

    section :account_menu, AccountMenu, 'ul#user-navigation-handheld'
    element :hamburger_menu, 'ul#main-navigation-handheld'
    section :links, HeaderLinks, '#main-navigation'

    def open_account_menu
      wait_until_user_account_logo_visible
      user_account_logo.click
      account_menu.should be_visible
    end  

    def navigate_to_account_option(link_name)
      open_account_menu
      account_menu.find("a", :text => "#{link_name}").click
    end

    def click_log_out
      open_account_menu
      account_menu.sign_out_button.click
    end

    def navigate_to_hamburger_menu_option(link_name)
      wait_for_main_menu
      main_menu.click
      hamburger_menu.should be_visible
      hamburger_menu.find("a", :text => "#{link_name}").click
    end

    def navigate_to(link_name)
      link = link_name.downcase.gsub(' ', '_').gsub('&', 'and')
      if links.respond_to?(link)
        links.send(link).click
      else
        raise "Not recognised header navigation link: #{link}"
      end
    end

  end
end
