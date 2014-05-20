module PageModels
  module ConfirmPageActions

    def submit_incomplete_payment_details(card_field)
      card_details = set_valid_card_details('VISA')
      symbol = card_field.downcase.gsub(' ' ,'_').to_sym
      if card_details[symbol].nil?
        raise "unsupported card field '#{symbol}'"
      end
      card_details[symbol] = ''
      enter_card_details(card_details)
      enter_billing_details
      confirm_and_pay_page.confirm_and_pay.click
    end

    def submit_payment_details_with_past_expiry_date
      current_year = Time.now.year
      current_month = Time.now.month
      if current_month == 1
        pending "Current month is January, so this test will not run in the current month, as the form will not allow to select the previous year"
      else
        card_details = set_valid_card_details('VISA')
        card_details[:expiry_month] = (current_month-1).to_s #This will ensure that an expired month is selected in the current year
        card_details[:expiry_year] = current_year.to_s
        enter_card_details(card_details)
        enter_billing_details
        confirm_and_pay_page.confirm_and_pay.click
      end
    end

    def submit_incomplete_billing_details(missing_field)
      symbol = missing_field.downcase.gsub(' ','_').to_sym
      fields = billing_details
      if fields[symbol].nil?
        raise "Unsupported address field '#{symbol}'"
      end
      fields[symbol] = ''
      enter_card_details(set_valid_card_details('VISA'))
      enter_billing_details(fields)
      confirm_and_pay_page.confirm_and_pay.click
    end

    def submit_incorrect_numeric_billing_details(missing_field)
      symbol = missing_field.downcase.gsub(' ','_').to_sym
      fields = billing_details
      if fields[symbol].nil?
        raise "Unsupported address field '#{symbol}'"
      end
      fields[symbol] = '12345'
      enter_card_details(set_valid_card_details('VISA'))
      enter_billing_details(fields)
      confirm_and_pay_page.confirm_and_pay.click
    end

   def submit_malformed_post_code(malformed_postcode)
     fields = billing_details
     fields[:postcode] = malformed_postcode
     enter_card_details(set_valid_card_details('VISA'))
     enter_billing_details(fields)
     confirm_and_pay_page.confirm_and_pay.click
   end
  end
end

World(PageModels::ConfirmPageActions)