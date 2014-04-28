module PageModels
  class Navigation < PageModels::BlinkboxbooksSection
    element :featured, '[data-test="header-featured"]'
    element :categories, '[data-test="header-categories-link"]'
    element :bestsellers, '[data-test="header-bestsellers-link"]'
    element :new_releases, '[data-test="header-new-releases-link"]'
    element :free_ebooks, '[data-test="header-top-free-link"]'
    element :authors, '[data-test="header-authors-link"]'
  end

  class Header < PageModels::BlinkboxbooksSection
    element :account_options_dropdown, 'ul#user-navigation-handheld'
    section :navigation, Navigation, '#main-navigation'
    element :user_account_logo, '#user-menu'
    element :main_menu, '#main-menu'
    element :main_menu_option_dropdown, 'ul#main-navigation-handheld'
    element :welcome, '.username'
    element :search_input, '[data-test="search-input"]'
    element :search_button, '[data-test="search-button"]'
    element :sub_menu, 'ul.submenu'
    element :suggestions, 'ul#suggestions'

    def account_nav_link(menu, link_name)
      menu.find("a", :text => "#{link_name}")
    end

    def navigate_to_account_option(link_name)
      wait_until_user_account_logo_visible #siteprism method
      user_account_logo.click
      account_options_dropdown.should be_visible
      account_nav_link(account_options_dropdown, link_name).click
    end

    def navigate_to_main_menu_option(sub_menu_item, link_name)
      wait_for_main_menu
      main_menu.click
      main_menu_option_dropdown.should be_visible
      account_nav_link(main_menu_option_dropdown, sub_menu_item).click
      wait_for_sub_menu
      account_nav_link(main_menu_option_dropdown, link_name).click
    end
  end
end
