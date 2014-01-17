module PageModels
  module ConfirmAndPayPageAsserts
    def assert_confirm_and_pay_button_status(button_status)
      if (button_status.include?('disabled'))
        confirm_and_pay_page.confirm_and_pay[:class].should be_eql('disabled_button')
      else
        confirm_and_pay_page.confirm_and_pay[:class].should be_eql('yellow_button')
      end
    end

    def assert_payment_failure_message
      expect(page).to have_content "We're sorry but your payment did not go through"
    end

  end
end
World(PageModels::ConfirmAndPayPageAsserts)