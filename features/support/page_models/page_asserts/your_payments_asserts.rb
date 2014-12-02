module PageModels
  module YourPaymentsAsserts
    def assert_default_card(card)
      refresh_current_page
      default_card = your_payments_page.default_card
      expect(card).to eq(default_card.title + default_card.holder_name)
    end

    def assert_book_order_and_payment_history(book_title)
      your_account_page.wait_until_spinner_invisible
      order_and_payment_history_page.wait_for_book_list
      expect(order_and_payment_history_page.book_list.text).to match(/#{Regexp.escape(book_title)}/i)
    end

    def assert_payment_card_saved(card_count, name_on_card, card_type)
      your_account_page.wait_until_spinner_invisible
      # TODO: www.test environment braintree user id pointer issue fix - revert to 'have(card_count).items' once resolved :
      expect(your_payments_page.saved_cards).to have_at_least(card_count).items
      expect(your_payments_page).to have_credit_card(card_type.downcase, :holder_name => name_on_card.upcase)
    end
  end
end
World(PageModels::YourPaymentsAsserts)