module PageModels
  module YourPersonalDetailsAsserts
    def expect_account_tab_selected(tab_name)
      your_account_page.account_nav_frame.should have_account_nav_tab_selected(tab_name)
    end

    def assert_user_greeting_message_displayed(first_name=nil)
      first_name ||= "Hi,"
      current_page.header.welcome.should have_content(first_name, :visible => true)
    end

    def assert_user_greeting_message_not_displayed()
      current_page.header.welcome.text.should be_eql("")
    end

    def assert_marketing_preferences(after_status)
      your_personal_details_page.wait_until_marketing_prefs_visible
      if (after_status)
        your_personal_details_page.marketing_prefs.should be_checked
      else
        your_personal_details_page.marketing_prefs.should_not be_checked
      end
    end

    def assert_clubcard (clubcard_number = '')
      sleep(1)
      expect(your_personal_details_page.club_card.value).to eql(clubcard_number.to_s)
    end

  end
end
World(PageModels::YourPersonalDetailsAsserts)