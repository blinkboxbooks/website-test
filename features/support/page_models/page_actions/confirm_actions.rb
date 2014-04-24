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