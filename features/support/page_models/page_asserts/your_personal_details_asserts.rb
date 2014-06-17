module PageModels
  module YourPersonalDetailsAsserts
    def expect_account_tab_selected(tab_name)
      expect(your_account_page.account_nav_frame.selected_tab.title).to eq(tab_name)
    end

    def assert_user_greeting_message_displayed(first_name=nil)
      first_name ||= 'Hi,'
      expect(current_page.header.welcome).to have_content(first_name, :visible => true)
    end

    def assert_user_greeting_message_not_displayed
      expect(current_page.header.welcome.text).to be_empty
    end

    def assert_marketing_preferences(after_status)
      your_personal_details_page.wait_until_marketing_prefs_visible

      status_now = your_personal_details_page.marketing_prefs.checked?

      expect(status_now).to eq after_status
    end

    def assert_clubcard (clubcard_number = '')
      your_personal_details_page.wait_until_club_card_visible
      expect(your_personal_details_page.club_card.value).to eql(clubcard_number.to_s)
    end

  end
end
World(PageModels::YourPersonalDetailsAsserts)
