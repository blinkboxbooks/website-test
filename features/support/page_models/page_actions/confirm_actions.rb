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

    def submit_incomplete_billing_details (address_field)
      card_details = set_valid_card_details('VISA')
      enter_card_details(card_details)
      case address_field
        when 'Address line one'
          #enter_billing_details
          enter_address_line_one('')
          enter_address_line_two('anything')
          enter_town_or_city('London')
          enter_post_code('WC1X8AQ')
        when 'Town or city'
          enter_address_line_one('28-30 Kirby Street')
          enter_address_line_two('anything')
          enter_town_or_city('')
          enter_post_code('WC1X8AQ')
        when 'Postcode'
          enter_address_line_one('28-30 Kirby Street')
          enter_address_line_two('anything')
          enter_town_or_city('London')
          enter_post_code('')
      end
      confirm_and_pay_page.confirm_and_pay.click
    end

    def submit_incorrect_numeric_billing_details (address_field)
      card_details = set_valid_card_details('VISA')
      enter_card_details(card_details)
      case address_field
        when 'Address line one'
          enter_address_line_one('12345')
          enter_address_line_two('Anything')
          enter_town_or_city('London')
          enter_post_code('WC1X8AQ')
        when 'Address line two'
          enter_address_line_one('28-30 Kirby Street')
          enter_address_line_two('12345')
          enter_town_or_city('London')
          enter_post_code('WC1X8AQ')
        when 'Town or city'
          enter_address_line_one('28-30 Kirby Street')
          enter_address_line_two('anything')
          enter_town_or_city('12345')
          enter_post_code('WC1X8AQ')
        when 'Postcode'
          enter_address_line_one('28-30 Kirby Street')
          enter_address_line_two('anything')
          enter_town_or_city('London')
          enter_post_code('12345')
      end
      confirm_and_pay_page.confirm_and_pay.click
    end

   def submit_malformed_post_code (value)
     card_details = set_valid_card_details('VISA')
     enter_card_details(card_details)
     enter_address_line_one('28-30 Kirby Street')
     enter_address_line_two('Anything')
     enter_town_or_city('London')
     enter_post_code(value)
     confirm_and_pay_page.confirm_and_pay.click
   end
  end
end

World(PageModels::ConfirmPageActions)