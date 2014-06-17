module PageModels
  module ConfirmAndPayPageAsserts
    def assert_confirm_and_pay_button_status(button_status)
      if button_status.include?('disabled')
        expect(confirm_and_pay_page.confirm_and_pay[:class]).to eq('disabled_button')
      else
        expect(confirm_and_pay_page.confirm_and_pay[:class]).to eq('yellow_button')
      end
    end

    def assert_payment_failure_message
      expect(page).to have_content "We're sorry but your payment did not go through"
    end

    def assert_credit_on_confirm_pay_page(account_credit)
      credit = confirm_and_pay_page.account_credit_amount
      expect(credit).to eq(account_credit.to_f.round(2))
    end

    def assert_amount_left_to_pay(account_credit, book_price)
      amount_to_pay = confirm_and_pay_page.amount_left_to_pay.text.gsub(/£/, '').to_f
      expect(amount_to_pay).to eq((book_price-account_credit.to_f).round(2))
    end

    def assert_book_exists_in_library_message(type)
      expect(confirm_and_pay_page).to have_already_purchased_message
      assert_message_displayed("You already have this #{type} in your library")
    end

  end
end
World(PageModels::ConfirmAndPayPageAsserts)