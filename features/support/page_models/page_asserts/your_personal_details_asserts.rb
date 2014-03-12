module PageModels
  module ManageAccountAsserts
    def expect_account_tab_selected(tab_name)
      your_account_page.account_nav_frame.should have_account_nav_tab_selected(tab_name)
    end

    def assert_marketing_preferences(after_status)
      if (after_status)
        your_personal_details_page.marketing_prefs.should be_checked
      else
        your_personal_details_page.marketing_prefs.should_not be_checked
      end
    end

    def assert_user_greeting_message_displayed(first_name=nil)
      first_name ||= "Hi,"
      current_page.header.welcome.should have_content(first_name, :visible => true)
    end

    def assert_user_greeting_message_not_displayed()
      current_page.header.welcome.text.should be_eql("")
    end

    def assert_default_card(card)
      within your_payments_page.default_card do
        default_card = your_payments_page.card_name.text
        card.should be_eql(default_card)
      end
    end

    def assert_book_order_and_payment_history(book_title)
      within(order_and_payment_history_page.ordered_books) do
        your_account_page.wait_until_spinner_invisible
        within(order_and_payment_history_page.book_list) do
          page.text should match /#{book_title}/i
        end
      end
    end

    def assert_payment_card_saved(card_count, name_on_card, card_type)
      your_account_page.wait_until_spinner_invisible
      within(your_payments_page.saved_cards_container) do
        your_payments_page.should have_saved_cards_list :count => card_count
        page.text.downcase.should include name_on_card.downcase
        page.text.downcase.should include card_type.downcase
      end
    end

    def assert_clubcard (clubcard_number = '')
      sleep(1)
      expect(your_personal_details_page.club_card.value).to eql(clubcard_number.to_s)
    end

  end
end
World(PageModels::ManageAccountAsserts)