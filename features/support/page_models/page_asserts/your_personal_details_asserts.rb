module PageModels
  module YourPersonalDetailsAsserts
    def expect_account_tab_selected(tab_name)
      expect(your_account_page.account_nav_frame.selected_tab.title).to eq(tab_name)
    end

    def assert_user_greeting_message_displayed(first_name)
      expect(current_page.header.user_name_displayed).to eq(first_name)
    end

    def assert_user_greeting_message_not_displayed
      expect(logged_in_session?).to eq(false)
    end

    def assert_marketing_preferences(after_status)
      refresh_current_page
      your_personal_details_page.wait_until_marketing_prefs_visible
      expect { your_personal_details_page.marketing_prefs.checked? == after_status }.to become_true, "Expected marketing preference: #{after_status}, got: #{!after_status}"
    end

    def assert_clubcard(clubcard_number = '')
      refresh_current_page
      your_personal_details_page.wait_until_club_card_visible
      expect(your_personal_details_page.club_card.value).to eql(clubcard_number.to_s)
    end

    def assert_name_on_personal_details_page(first_name, last_name)
      expect(your_personal_details_page.first_name).to eq(first_name)
      expect(your_personal_details_page.last_name).to eq(last_name)
    end

    def edit_marketing_preferences
      your_personal_details_page.marketing_prefs_label.click
      your_personal_details_page.marketing_prefs.checked?
    end

    def assert_number_of_saved_cards(expected_cards)
      expect(your_payments_page.saved_cards).to have_exactly(expected_cards).items
    end

    def assert_email_address(email_address, refresh = true)
      refresh_current_page if refresh
      expect(your_personal_details_page.email_address.value).to eq(email_address)
    end
  end
end

World(PageModels::YourPersonalDetailsAsserts)
