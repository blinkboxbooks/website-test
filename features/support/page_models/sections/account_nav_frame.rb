module PageModels
  class AccountNavFrame < PageModels::BlinkboxbooksSection
    element :account_nav_menu, ".account_menu"

    def account_nav_tab(tab_name)
      account_nav_menu.find("a", :text => tab_name)
    end

    def navigate_to_account_tab(tab_name)
      expect(self).to have_account_nav_menu
      account_nav_tab(tab_name).click
    end

    def has_account_nav_tab_selected?(tab_name)
      expect(self).to have_account_nav_menu
      self.has_selector?('.selected', :text => tab_name)
    end
  end
end