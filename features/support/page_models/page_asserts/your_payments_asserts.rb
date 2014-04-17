module PageModels
  module YourPaymentsAsserts
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
        your_payments_page.should have_saved_cards :count => card_count
        page.text.downcase.should include name_on_card.downcase
        page.text.downcase.should include card_type.downcase
      end
    end
  end
end
World(PageModels::YourPaymentsAsserts)