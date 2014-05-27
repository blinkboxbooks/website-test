module PageModels
  module YourPaymentsAsserts
    def assert_default_card(card)
      default_card = your_payments_page.default_card
      expect(card).to be == default_card.title + default_card.holder_name
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
      expect(your_payments_page).to have_saved_cards(:count => card_count)
      expect(your_payments_page.saved_cards).to have_credit_card(card_type.downcase, :holder_name => name_on_card.downcase)
    end
  end
end
World(PageModels::YourPaymentsAsserts)