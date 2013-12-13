module PageModels
  module ConfirmAndPayPageAsserts
      def assert_confirm_and_pay_button_status(button_status)

        if (button_status.include?('disabled'))
          find_button('Confirm & pay', disabled: true)[:disabled].eql?('true')
        else
          find_button('Confirm & pay')[:disabled].should_not be
        end
      rescue Capybara::ElementNotFound
        raise "Confirm and Pay button is not #{button_status} as expected"

      end
    end
end
World(PageModels::ConfirmAndPayPageAsserts)