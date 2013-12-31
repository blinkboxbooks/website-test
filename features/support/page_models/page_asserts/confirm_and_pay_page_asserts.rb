module PageModels
  module ConfirmAndPayPageAsserts
      def assert_confirm_and_pay_button_status(button_status)
        selector = confirm_and_pay_page.confirm_and_pay
        if (button_status.include?('disabled'))
          find_button(selector.text, disabled: true)[:disabled].eql?('true')
        else
          find_button(selector.text)[:disabled].should_not be
        end
      rescue Capybara::ElementNotFound
        raise "Confirm and Pay button is not #{button_status} as expected"

      end

      def assert_payment_failure_message
        expect(page).to have_content "We're sorry but your payment did not go through"
      end
    end
end
World(PageModels::ConfirmAndPayPageAsserts)