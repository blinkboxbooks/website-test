module PageModels
  module ConfirmPageActions

    def submit_incomplete_payment_details(card_field)
      card_details = set_valid_card_details('VISA')
      case card_field.downcase
        when 'card number'
          card_details[:card_number] = ''
        when 'cvv'
          card_details[:cvv] = ''
        when 'name on card'
          card_details[:name_on_card] = ''
      end
      enter_card_details(card_details)
      enter_billing_details
      confirm_and_pay_page.confirm_and_pay.click
    end

    def submit_payment_details_with_past_expiry_date
      card_details = set_valid_card_details('VISA')
      card_details[:expiry_month] = '01'
      card_details[:expiry_year] = '2014' #This solution will only work till 31-12-2014, need to discuss a long term solution.
      enter_card_details(card_details)
      enter_billing_details
      confirm_and_pay_page.confirm_and_pay.click
    end
  end
end

World(PageModels::ConfirmPageActions)