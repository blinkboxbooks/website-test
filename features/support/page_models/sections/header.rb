module PageModels
  class AccountMenu < PageModels::BlinkboxbooksSection
    element :sign_out_button, 'a[data-test="menu-sign-out-button"]'
    element :sign_in_button, 'a[data-test="menu-sign-in-button"]'
    element :menu_register_link, '[data-test="menu-register-link"]'
    element :order_history, 'a[data-test="order-history"]'
    element :personal_details, 'a[data-test="personal-details"]'
    element :saved_cards, 'a[data-test="saved-cards"]'
    element :devices, 'a[data-test="devices"]'
  end

  class HeaderTab < PageModels::BlinkboxbooksSection
    element :link, 'a'

    def title
      link.text
    end

    def data_test
      link['data-test']
    end

    def selected?
      root_element[:class] =~ /current/
    end

    def click
      puts "Click on #{title} header tab"
      link.click
    end
  end

  class Header < PageModels::BlinkboxbooksSection
    element :user_account_logo, '#user-menu'
    element :main_menu, '#main-menu'
    element :welcome, '.username'
    element :search_input, '[data-test="search-input"]'
    element :search_button, '[data-test="search-button"]'
    element :suggestions, 'ul#suggestions'
    element :logo, '#logo a'
    elements :all_links, 'a'

    section :account_menu, AccountMenu, 'ul#user-navigation-handheld'
    element :hamburger_menu, 'ul#main-navigation-handheld'
    sections :tabs, HeaderTab, '#main-navigation li'

    def selected_tab
      tabs.find { |tab| tab.selected? }
    end

    def tab(tab_name)
      #                                     Inconsistent data-test naming made me do this |
      # The weak link is "Free eBooks" with the data-test of "header-top-free-link"       ▽
      tabs.find { |tab| tab.data_test.downcase.include?(tab_name.downcase.gsub(' ', '-')) || tab.title.downcase.include?(tab_name.downcase) }
    end

    def open_account_menu
      wait_until_user_account_logo_visible
      user_account_logo.click
      expect(account_menu).to be_visible
    end  

    def navigate_to_account_option(link_name)
      open_account_menu
      link = link_name.downcase.gsub(' ', '_')
      if account_menu.respond_to?(link)
        account_menu.send(link).click
      else
        raise "Cannot find link \"#{link_name}\" in hamburger menu!"
      end
    end

    def find_link_by_text(link_text)
      all_links.find { |link| link.text == link_text }
    end

    def click_log_out
      open_account_menu
      account_menu.sign_out_button.click
    end

    def navigate_to_hamburger_menu_option(link_name)
      wait_for_main_menu
      main_menu.click
      expect(hamburger_menu).to be_visible
      hamburger_menu.find('a', :text => "#{link_name}").click
    end

    def navigate_to(link_name)
      header_tab = tab(link_name)
      unless header_tab.nil?
        header_tab.click
      else
        raise "Not recognised header navigation link: #{link_name}"
      end
    end
  end
end
