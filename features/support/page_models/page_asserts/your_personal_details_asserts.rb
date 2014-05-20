module PageModels
  module YourPersonalDetailsAsserts
    def expect_account_tab_selected(tab_name)
      expect(your_account_page.account_nav_frame).to have_account_nav_tab_selected(tab_name)
    end

    def assert_user_greeting_message_displayed(first_name=nil)
      first_name ||= "Hi,"
      expect(current_page.header.welcome).to have_content(first_name, :visible => true)
    end

    def assert_user_greeting_message_not_displayed()
      expect(current_page.header.welcome.text).to equal("")
    end

    def assert_marketing_preferences(after_status)
      your_personal_details_page.wait_until_marketing_prefs_visible
      if (after_status)
        expect(your_personal_details_page.marketing_prefs).to be_checked
      else
        expect(your_personal_details_page.marketing_prefsex).to_not be_checked
      end
    end

    def assert_clubcard (clubcard_number = '')
      sleep(1)
      expect(your_personal_details_page.club_card.value).to equal(clubcard_number.to_s)
    end

  end
end
World(PageModels::YourPersonalDetailsAsserts)